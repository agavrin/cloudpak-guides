FROM phusion/baseimage:bionic-1.0.0

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

################################
# Download and install packages
################################

RUN install_clean git wget unzip jq nano make

WORKDIR /tmp

# Download script into /root/install/discovery-data/2.2.0/
RUN git clone https://github.com/watson-developer-cloud/doc-tutorial-downloads.git \
&& cd doc-tutorial-downloads \
&& tar -cvzf wd-backup.tar.gz discovery-data \
&& mv wd-backup.tar.gz /root/install \
&& cd /root/install/ \
&& tar -xvzf wd-backup.tar.gz \
&& rm -fr wd-backup.tar.gz \
&& cd /tmp

# Install cpd-cli
RUN cd /usr/local/bin/ \
&& wget -O cpd-cli.tgz "https://github.com/IBM/cpd-cli/releases/download/v3.5.4/cpd-cli-linux-EE-3.5.4.tgz" \
&& tar -zxvf cpd-cli.tgz \
&& rm -fr cpd-cli.tgz \
&& rm -fr repo.yaml \
&& cd /tmp/

# cloudctl
RUN wget --no-verbose https://github.com/IBM/cloud-pak-cli/releases/download/v3.8.0/cloudctl-linux-amd64.tar.gz \
 && tar -xzf cloudctl-linux-amd64.tar.gz \
 && mv cloudctl-linux-amd64 /usr/bin/cloudctl

# oc and kubectl
RUN wget --no-verbose https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-4.6/openshift-client-linux.tar.gz \
 && tar -xzf openshift-client-linux.tar.gz \
 && mv oc /usr/bin/ \
 && mv kubectl /usr/bin/

# helm install
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add - \
 && apt-get install apt-transport-https --yes \
 && echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
 && apt-get update \
 && apt-get install helm

# ibmcloud cli (not essential)
RUN wget --no-verbose -O ibmcloud-installer.tgz https://clis.cloud.ibm.com/download/bluemix-cli/latest/linux64 \
 && tar -xzf ibmcloud-installer.tgz \
 && Bluemix_CLI/install \
 && echo 'alias ic=ibmcloud' >> $HOME/.profile

###################################
# Dir for mounting template files
###################################
RUN mkdir -p $HOME/install

WORKDIR /root/install

############
# Clean up
############
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
