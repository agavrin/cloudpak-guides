## Установка CP4MCM в облаке IBM

Зависимости:
- helm https://helm.sh/docs/intro/install/
- IBM Cloud CLI https://cloud.ibm.com/docs/cli
- jq
- cloudctl `curl -sL https://ibm.biz/idt-installer | bash`

## Пример запуска скрипта по установке CP4MCM

``` bash
git clone https://github.com/ibm-garage-tsa/cp4mcm-installer.git
cd cp4mcm-installer/
# Ключ для установки ПО - https://myibm.ibm.com/products-services/containerlibrary
export ENTITLED_REGISTRY_KEY="eyJhbGciOiJIU....Vrgow"

# Путь к файлу Red Hat pull secret - https://cloud.redhat.com/openshift/install/pull-secret
export RED_HAT_PULL_SECRET_PATH="/home/ag/pull-secret.txt"

export CP4MCM_RHACM_ENABLED="true"
export CP4MCM_INFRASTRUCTUREMANAGEMENT_ENABLED="true"
export CP4MCM_RHACM_OBSERVABILITY_ENABLED="true"
export CP4MCM_BLOCK_STORAGECLASS=""
export CP4MCM_FILE_STORAGECLASS=""
export LOGDIR=/home/ag/cp4mcm-installer/

# fix the helm command issue
# helm install $MINIO_CHART_NAME minio/minio \
sed -i -e 's/stable/minio/g' rhacm/2-minio.sh
# Logs folder location fix
sed -i -e 's/PWD/pwd/g' setup_env.sh

oc login --token=sha256~y5qLki9B6ZN....6BtAdKMPN_Z-2i7ZZi0 --server=https://c100-e.eu-de.containers.cloud.ibm.com:30413

make

```
