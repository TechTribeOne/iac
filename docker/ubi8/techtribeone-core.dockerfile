FROM redhat/ubi8

LABEL \
  com.techtribeone.maintainer='sean conley <sean.conley@techtribeone.com>' \
  com.techtribeone.vendor='techtribeone' \
  license='MIT' name='core' description='core' url='https://github.com/techtribeone/iac/docker'

RUN \
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
&& yum -y update \
&& yum -y install \
  bash \
  coreutils-single \
  file \
  grep \
  less \
  openssh-clients \
  openssl \
  python3 \
  rsync \
  screen \
  tar \
  unzip \
  vim \
  zip \
&& python3 -m pip install -qU pip \
&& python3 -m pip install -qU virtualenv \
&& yum clean all \
&& rm -rf /var/cache/dnf/* /var/cache/yum/* \
