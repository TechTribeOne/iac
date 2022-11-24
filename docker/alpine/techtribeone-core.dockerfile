FROM alpine:3.16

LABEL \
  com.techtribeone.maintainer='sean conley <sean.conley@techtribeone.com>' \
  com.techtribeone.vendor='techtribeone' \
  license='MIT' name='core' description='core' url='https://github.com/techtribeone/iac/docker'

ADD overlay/ /
RUN \
apk -Uuv add \
  bash \
  busybox \
  coreutils \
  curl \
  file \
  fzf \
  grep \
  less \
  mlocate \
  openssh-client \
  openssl \
  perl \
  py3-pip \
  python3 \
  rsync \
  screen \
  tar \
  unzip \
  vim \
  zip \
  zsh \
  zsh-vcs \
&& python3 -m pip install virtualenv \
&& rm -rf /var/cache/apk/* /root/.cache
