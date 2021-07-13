#!/bin/bash
source lib/functions.sh
source _customization.sh

export LOGDIR="${LOGDIR:-$(pwd)/_logs}"
mkdir -p "$LOGDIR"
export LOGFILE="$LOGDIR/install-$(date +"%Y-%m-%d").log"

log  "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
log  "Installation is starting with the following configuration:"
log  "CP4D_VERSION=$CP4D_VERSION"
log  "WD_VERSION=$WD_VERSION"

# Check environmental variables provided in _customization.sh
if [ -z "${ENTITLED_REGISTRY_KEY}" ]; 	then echo -e "\e[33m" "Provide ENTITLED_REGISTRY_KEY\e[0m"; exit; fi
if [ -z "${CP4D_VERSION}" ]; 						then echo -e "\e[33m" "Provide CP4D_VERSION\e[0m"; exit; fi
if [ -z "${WD_VERSION}" ]; 							then echo -e "\e[33m" "Provide WD_VERSION\e[0m"; exit; fi
log "cpd-cli VERSION="
execlog "cpd-cli version"
log  "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

export CPDKEY=${ENTITLED_REGISTRY_KEY}

[ -d ~/cpd3.5 ] || mkdir ~/cpd3.5
cd ~/cpd3.5

oc project $NAMESPACE
if [ $? -ne 0 ]; then
		oc new-project $NAMESPACE
		if [ $? -ne 0 ]; then
			echo -e "\e[31m#### Error - please login to your cluster first\e[0m."
			exit
		else
			echo -e "\e[32m#### Created $NAMESPACE  project\e[0m."
		fi
else
	echo -e "\e[32m#### Switched to $NAMESPACE  project\e[0m."
fi

oc patch configs.imageregistry.operator.openshift.io/cluster --type merge -p '{"spec":{"defaultRoute":true}}'

cp /root/install/wd/repo.cpd351_wd220.yaml ~/cpd3.5/
cp /root/install/wd/wd-override* ~/cpd3.5/

sed -i "s/##CPD_USER##/cp/g" ~/cpd3.5/repo.cpd351_wd220.yaml
sed -i "s/##CPD_KEY##/$ENTITLED_REGISTRY_KEY/g" ~/cpd3.5/repo.cpd351_wd220.yaml

log "Installing Cloud Pak for Data..."
log "================================"

# Preparation for Cp4D installation
execlog "cpd-cli adm --repo repo.cpd351_wd220.yaml -a lite --version $CP4D_VERSION -n $NAMESPACE --apply --accept-all-licenses"
checkCommandResult

# Install CP4D
execlog "cpd-cli install --version $CP4D_VERSION --repo repo.cpd351_wd220.yaml --assembly lite --namespace $NAMESPACE -c ${STORCS_CPD} --accept-all-licenses --insecure-skip-tls-verify"
checkCommandResult

export OPTS="--accept-all-licenses --insecure-skip-tls-verify"

log "Installing Watson Discovery..."
log "================================"

execlog "cpd-cli adm --repo repo.cpd351_wd220.yaml -a watson-discovery --version $WD_VERSION -n $NAMESPACE --apply --accept-all-licenses"
checkCommandResult

execlog "cpd-cli install --assembly edb-operator --optional-modules edb-pg-base:x86_64 --version 3.5.0 --namespace $NAMESPACE --repo repo.cpd351_wd220.yaml --ask-push-registry-credentials -c ${STORCS_EDB} ${OPTS}"
checkCommandResult

execlog "cpd-cli install -v $WD_VERSION --repo repo.cpd351_wd220.yaml -a watson-discovery -n $NAMESPACE  --override wd-override.$DEPLOYTYPE.yaml -c ${STORCS_WD} ${OPTS}"
checkCommandResult
