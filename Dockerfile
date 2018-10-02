FROM ubuntu:18.04

ENV terraform_version=0.11.7

WORKDIR /workdir

# Setup apt to fetch OEM packages from NZ, and disable source repositories
# Then install dependencies and cloud tools
# Finally remove anything unnecessary and cleanup
RUN sed -i'' 's/archive.ubuntu.com/nz.archive.ubuntu.com/g' /etc/apt/sources.list && \
    sed -i'' -e 's/^deb-src/# deb-src/' /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python-openstackclient python-oslo.log bash-completion unzip gnupg lsb-release curl wget less && \
    apt-get install --no-install-recommends -y awscli groff jq && \
    mkdir /etc/bash_completion.d && openstack complete > /etc/bash_completion.d/openstack && \
    curl -sS https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip | funzip > /usr/local/bin/terraform && \
    chmod +x /usr/local/bin/terraform && \
    echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y google-cloud-sdk kubectl && \
    apt-get install --no-install-recommends -y npm && \
    npm install -g firebase-tools && \
    apt-get remove -y unzip && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
