FROM quay.io/centos/centos:stream9

LABEL \
  name='techtribeone/centos/core' version='0.1' license='MIT' \
  description='tools for general command-line interface utility usage' \
  url='https://github.com/techtribeone/iac/docker/' \
  vendor='techtribeone' maintainer='sean conley <sean.conley@techtribeone.com>'

RUN \
yum -y install epel-release && \
yum -y update && \
yum -y install \
  bash \
  busybox \
  coreutils-single \
  curl-minimal \
  file \
  grep \
  less \
  openssl \
  pip \
  python3 \
  screen \
  tar \
  unzip \
  vim \
  zip \
  zsh \
  && \
pip install -q virtualenv && \
yum clean all && \
rm -rf /var/cache/dnf/* /var/cache/yum/*
