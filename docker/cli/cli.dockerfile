FROM alpine:3.11

LABEL maintainer='sean conley <slconley@gmail.com>' license='MIT' name='CLI'\
  description='lightweight CLIs' url='https://github.com/slconley/docker' \
  vendor='slconley' version='1.1'

RUN \
echo $'\
@edge http://dl-cdn.alpinelinux.org/alpine/edge/main\n\
@edgecommunity http://dl-cdn.alpinelinux.org/alpine/edge/community\n\
@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing\n\
' >> /etc/apk/repositories && \
apk -Uuv add groff less python3 tar gzip curl postgresql-client mysql-client vim bind bind-tools && \
pip3 install --upgrade pip awscli aws-amicleaner future wheel &&  \
cd /bin && \
ln -s pip3 pip && \
curl -skL 'https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64' -o /bin/jq && \
chmod 755 jq && \
chown root:root  jq && \
rm /var/cache/apk/* && \
mkdir -p /workspace

VOLUME ["/workspace"]
WORKDIR /workspace
