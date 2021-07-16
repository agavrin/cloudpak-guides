#FROM alpine:3.14
FROM frolvlad/alpine-glibc

###################################
# Install necessary packages
###################################
RUN apk add --no-cache bash git ncurses wget unzip nano make

###################################
# Dir for mounting template files
###################################
RUN mkdir -p $HOME/install && mkdir -p $HOME/wd

WORKDIR /tmp

###################################
# Download backup script into /root/install/discovery-data/ from https://github.com/watson-developer-cloud/doc-tutorial-downloads
###################################
RUN git clone https://github.com/watson-developer-cloud/doc-tutorial-downloads.git \
 && cd doc-tutorial-downloads \
 && tar -cvzf wd-backup.tar.gz discovery-data \
 && mv wd-backup.tar.gz /root/wd/ \
 && cd /root/wd/ \
 && tar -xvzf wd-backup.tar.gz \
 && rm -fr wd-backup.tar.gz \
 && cd /tmp \
 && rm -fr doc-tutorial-downloads

###################################
# Install cpd-cli
###################################
RUN cd /usr/local/bin/ \
 && wget -O cpd-cli.tgz "https://github.com/IBM/cpd-cli/releases/download/v3.5.4/cpd-cli-linux-EE-3.5.4.tgz" \
 && tar -zxvf cpd-cli.tgz \
 && rm -fr cpd-cli.tgz \
 && rm -fr repo.yaml \
 && cd /tmp/

###################################
# Install oc and kubectl
###################################
RUN wget --no-verbose https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-4.6/openshift-client-linux.tar.gz \
 && tar -xzf openshift-client-linux.tar.gz \
 && mv oc /usr/bin/ \
 && mv kubectl /usr/bin/ \
 && rm -fr openshift-client-linux.tar.gz \
 && /usr/bin/oc \
 && /usr/bin/kubectl

WORKDIR /root/install

############
# Clean up
############
RUN rm -rf /var/cache/apk/* && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && ln -sf /dev/null /dev/tty1 \
 && ln -sf /dev/null /dev/tty2 \
 && ln -sf /dev/null /dev/tty3 \
 && ln -sf /dev/null /dev/tty4 \
 && ln -sf /dev/null /dev/tty5 \
 && ln -sf /dev/null /dev/tty6

ENTRYPOINT ["/sbin/init"]
