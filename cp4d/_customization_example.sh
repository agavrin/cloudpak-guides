#
# IBM Entitled Registry Credentials
#
# https://myibm.ibm.com/products-services/containerlibrary
#

export ENTITLED_REGISTRY_KEY="eyJhbGciOiJIUzI1NiJ9.eyJpc3M...tHhbfbOOv37IdtczOOWNgMQwiVrgow"

# Version for CP4D and WD
#
export CP4D_VERSION="3.5.2"
export WD_VERSION="2.2.1"

# Provide storage class,
# For WD: use ibmc-block-gold
# For CP4D: use ibmc-file-gold-gid
# export STORCS_CPD="ibmc-file-gold-gid"
# export STORCS_EDB="ibmc-block-gold"
# export STORCS_WD="ibmc-block-gold"

export STORCS_CPD="ibmc-file-gold-gid"
export STORCS_EDB="ibmc-block-gold"
export STORCS_WD="ibmc-block-gold"

# use 'development' or 'production' for DEPLOYTYPE
export DEPLOYTYPE="development"

# Namespace - use 'zen' by default
export NAMESPACE="zen4"
