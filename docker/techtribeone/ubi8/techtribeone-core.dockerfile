FROM redhat/ubi9

LABEL maintainer='sean conley <sean.conley@techtribeone.com>' license='MIT' name='CORE'\
  description='core' url='https://github.com/techtribeone/iac/docker' \
  vendor='techtribeone' version='0.1'

RUN \
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm && \
yum -y update && \
yum -y install \
  bash \
  coreutils-single \
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
  && \
pip install -q virtualenv && \
yum clean all && \
rm -rf /var/cache/dnf/* /var/cache/yum/*


