FROM techtribeone/centos7-core

LABEL \
  name='techtribeone/centos/cli' version='0.1' license='MIT' \
  description='tools for general command-line interface ' \
  url='https://github.com/techtribeone/iac/docker/' \
  vendor='techtribeone' maintainer='sean conley <sean.conley@techtribeone.com>'

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


# ADD overlay/ /
# RUN \
# apk -Uuv add \
#   aws-cli \
#   bind-tools \
#   coreutils \
#   dnsmasq \
#   git \
#   gpg \
#   groff \
#   gzip \
#   jq \
#   kubectl@testing \
#   lynx \
#   mysql-client \
#   net-tools \
#   nmap \
#   openldap-clients \
#   openvpn \
#   postgresql-client \
#   sqlite \
#   squid \
#   sshpass \
#   step-cli \
#   step-cli-bash-completion \
#   step-cli-zsh-completion \
#   && \
# rm -f /var/cache/apk/*
