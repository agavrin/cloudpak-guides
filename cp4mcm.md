## Пример запуска скрипта по установке CP4MCM

``` bash
  git clone https://github.com/ibm-garage-tsa/cp4mcm-installer.git
  cd cp4mcm-installer/
  # Ключ для установки ПО - https://myibm.ibm.com/products-services/containerlibrary
  export ENTITLED_REGISTRY_KEY="eyJhbGciOiJIUzI1N...zOOWNgMQwiVrgow"

  # Путь к файлу Red Hat pull secret - https://cloud.redhat.com/openshift/install/pull-secret
  export RED_HAT_PULL_SECRET_PATH="/home/ag/cp4mcm-installer/pull-secret.txt"

  export CP4MCM_RHACM_ENABLED="true"
  export CP4MCM_INFRASTRUCTUREMANAGEMENT_ENABLED="true"
  export CP4MCM_RHACM_OBSERVABILITY_ENABLED="true"
  export CP4MCM_BLOCK_STORAGECLASS=""
  export CP4MCM_FILE_STORAGECLASS=""
  export LOGDIR=.

  oc login --token=sha256~y5qLki9B6ZN....6BtAdKMPN_Z-2i7ZZi0 --server=https://c100-e.eu-de.containers.cloud.ibm.com:30413
```
