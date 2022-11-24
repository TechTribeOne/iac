FROM quay.io/centos/centos:stream8

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
  curl \
  file \
  grep \
  less \
  mlocate \
  openssh-clients \
  openssl \
  python3 \
  rsync \
  screen \
  tar \
  unzip \
  vim \
  zip \
  zsh \
  && \
python3 -m pip install -q virtualenv && \
yum clean all && \
rm -rf /var/cache/dnf/* /var/cache/yum/*
