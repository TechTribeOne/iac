FROM alpine:3.15

ENV ANSIBLE_VERSION 2.12.1

ENV BUILD_PACKAGES \
  ansible \
  bash \
  curl \
  tar \
  openssh-client \
  sshpass \
  git \
  python \
  py-boto \
  py-dateutil \
  py-httplib2 \
  py-jinja2 \
  py-paramiko \
  py-pip \
  py-yaml \
  ca-certificates

LABEL maintainer='sean conley <sean.conley@techtribeone.com>' license='MIT' name='CICD'\
  description='CI/CD tools' url='https://github.com/techtribeone/iac/docker/cicd' \
  vendor='techtribeone' version='1.1'

RUN \
echo $'\
@edge http://dl-cdn.alpinelinux.org/alpine/edge/main\n\
@edgecommunity http://dl-cdn.alpinelinux.org/alpine/edge/community\n\
@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing\n\
' >> /etc/apk/repositories

RUN \
apk update && apk upgrade && \
apk --update add --virtual build-dependencies

RUN apk -Uu add gcc

RUN apk -Uuv add \
  musl-dev \
  libffi-dev

RUN apk -Uuv add \
  openssl-dev

# RUN apk -Uuv add \
#  python-dev

RUN apk -Uuv --no-cache add \
  py3-pip python3 tar gzip curl

# RUN apk -Uuv add --no-cache \
# ${BUILD_PACKAGES}

RUN \
pip install --upgrade pip awscli aws-amicleaner

RUN \
rm /var/cache/apk/* && \
mkdir -p /workspace

VOLUME ["/workspace"]
WORKDIR /workspace
