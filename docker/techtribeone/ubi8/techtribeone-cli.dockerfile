FROM techtribeone/ubi8-core

LABEL maintainer='sean conley <sean.conley@techtribeone.com>' license='MIT' name='CLI'\
  description='cli' url='https://github.com/techtribeone/iac/docker' \
  vendor='techtribeone' version='0.1'

RUN \
yum -y update && \
yum -y install \
  coreutils-single \
  dnsmasq \
  git \
  gpg \
  gzip \
  jq \
  net-tools \
  nmap \
  openldap \
  openvpn \
  sqlite \
  squid \
  sshpass \
  && \
yum clean all && \
rm -rf /var/cache/dnf/* /var/cache/yum/*
