FROM techtribeone/core

LABEL maintainer='sean conley <sean.conley@techtribeone.com>' license='MIT' name='CLI'\
  description='cli' url='https://github.com/techtribeone/iac/docker' \
  vendor='techtribeone' version='0.1'

ADD overlay/ /
RUN \
apk -Uuv add \
  aws-cli \
  bind-tools \
  coreutils \
  dnsmasq \
  git \
  gpg \
  groff \
  gzip \
  jq \
  kubectl@testing \
  lynx \
  mysql-client \
  net-tools \
  nmap \
  openldap-clients \
  openvpn \
  postgresql-client \
  sqlite \
  squid \
  sshpass \
  step-cli \
  step-cli-bash-completion \
  step-cli-zsh-completion \
  && \
rm -f /var/cache/apk/*
