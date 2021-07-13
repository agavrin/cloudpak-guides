### Building the environment container for WD installation

It is recommended that these scripts be executed from a Docker container to ensure that the required tools and packages are available. Docker can be installed for your system using instructions found [here](https://docs.docker.com/get-docker/). This deployment has been tested using Docker version 20.10.6.

1. Clone this repository.

2. Navigate to the directory containing this README.

3. Build your docker image with the following command:
``` bash
docker build . -t cp4d-wd
```

4. Run container with:
``` bash
docker run -d --name my-container --mount type=bind,source="$(pwd)",target=/root/install cp4d-wd
```

The current directory on the host has been bind-mounted to `/root/install` in the container. This allows file changes made in the host to be reflected in the container and vice versa. To create another cluster, clone the repo again in a **new directory** and create a **new container** (with a `--name` other than `my-container`). **Do not bind** multiple containers to the same host template directory.

### Deploying Cloud Pak for Data and WD on ROKS

1. Copy `_customization.example.sh` to `_customization.sh`. This file can be used to define values for variables. Update values in the file accordingly.

2. Log in to your container with
``` bash
docker exec -it my-container bash --login
```

3. Execute these commands **inside container bash**
``` bash
# Login into your OpenShift cluster - copy this command from your OpenShift console
oc login --token=sha256~Kb8...WAKdQM --server=https://c115...ud.ibm.com:30829
# Run the installation process
make
```

### Known issues
#### 1. ImagePullBackoff error for some pods

Sometimes (I've found it when I did second installation on the same cluster), you may get `ImagePullBackoff` error for some pods (postgres/rabbitmq/etcd)
*Cause*: The wrong image pull secret is being used.
*Solution*: Complete the following steps during the installation:
- Start installing Watson Discovery.
- After watson-discovery-operator module completes, check if a WatsonDiscovery custom resource is created by running the following command:
`` bash
oc get WatsonDiscovery wd
``

After the custom resource is created, run the following commands to point the correct image pull secret to pull images from the external registry:
`` bash
pull_secret=$(oc get secrets | grep 'docker-pull-.*-watson-discovery-registry-registry' | cut -d ' ' -f 1)
cat << EOS > discovery-patch.yaml
spec:
  shared:
    imagePullSecret: $pull_secret
EOS
oc patch wd wd --type=merge --patch "$(cat discovery-patch.yaml)"
``

If the RabbitMQ pods are still in ImagePullBackoff state, remove the RabbitMQ CR to enable the rabbitmq-operator to re-create the RabbitMQ clusters. You can use the following command:
`` bash
oc delete IbmRabbitmq wd-rabbitmq
``

More details you can found here: https://cloud.ibm.com/docs/discovery-data?topic=discovery-data-known-issues
