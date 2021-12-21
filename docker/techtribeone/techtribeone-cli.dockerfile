FROM alpine:3.15

LABEL maintainer='sean conley <sean.conley@techtribeone.com>' license='MIT' name='CLI'\
  description='cli' url='https://github.com/techtribeone/iac/docker' \
  vendor='techtribeone' version='0.1'

ADD overlay/ /
RUN \
apk -Uuv add \
  aws-cli \
  bash \
  bind-tools \
  busybox \
  coreutils \
  curl \
  dnsmasq \
  file \
  git \
  gpg \
  groff \
  gzip \
  jq \
  kubectl@testing \
  less \
  lynx \
  mysql-client \
  net-tools \
  nmap \
  openldap-clients \
  openssh \
  openssl \
  openvpn \
  postgresql-client \
  py3-pip \
  python3 \
  screen \
  sqlite \
  squid \
  sshpass \
  step-cli \
  step-cli-bash-completion \
  step-cli-zsh-completion \
  tar \
  unzip \
  vim \
  zip \
  zsh \
&& pip install virtualenv
