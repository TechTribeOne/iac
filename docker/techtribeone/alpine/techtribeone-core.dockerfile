FROM alpine:3.16

LABEL maintainer='sean conley <sean.conley@techtribeone.com>' license='MIT' name='CORE'\
  description='core' url='https://github.com/techtribeone/iac/docker' \
  vendor='techtribeone' version='0.1'

ADD overlay/ /
RUN \
apk -Uuv add \
  bash \
  busybox \
  coreutils \
  curl \
  file \
  grep \
  less \
  openssl \
  py3-pip \
  python3 \
  screen \
  tar \
  unzip \
  vim \
  zip \
  zsh \
  && \
rm -f /var/cache/apk/* && \
pip install virtualenv
