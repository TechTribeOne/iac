FROM alpine:3.15

LABEL maintainer='sean conley <sean.conley@techtribeone.com>' license='MIT' name='CLI'\
  description='lightweight CLIs' url='https://github.com/techtribeone/iac/docker' \
  vendor='techtribeone' version='1.1'

RUN \
echo $'\
@edge http://dl-cdn.alpinelinux.org/alpine/edge/main\n\
@edgecommunity http://dl-cdn.alpinelinux.org/alpine/edge/community\n\
@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing\n\
' >> /etc/apk/repositories \
&& apk -Uuv add groff less python3 py3-pip tar gzip curl postgresql-client mysql-client vim bind bind-tools jq coreutils

RUN \
pip3 install --upgrade pip awscli aws-amicleaner future wheel \
&& rm /var/cache/apk/* \
&& mkdir -p /workspace

VOLUME ["/workspace"]
WORKDIR /workspace
