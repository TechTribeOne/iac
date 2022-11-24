FROM quay.io/centos/centos:stream9

LABEL \
  com.techtribeone.maintainer='sean conley <sean.conley@techtribeone.com>' \
  com.techtribeone.vendor='techtribeone' \
  license='MIT' name='core' description='core' url='https://github.com/techtribeone/iac/docker'

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
  mlocate \
  openssh-clients \
  openssl \
  pip \
  python3 \
  rsync \
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
