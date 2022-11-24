FROM techtribeone/ubi9-core

LABEL \
  com.techtribeone.maintainer='sean conley <sean.conley@techtribeone.com>' \
  com.techtribeone.vendor='techtribeone' \
  license='MIT' name='cli' description='cli' url='https://github.com/techtribeone/iac/docker'

RUN \
yum -y update && \
yum -y install \
  bind-utils \
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
