FROM techtribeone/alpine-cli

LABEL maintainer='sean conley <sean.conley@techtribeone.com>' license='MIT' name='IAC'\
  description='IaC tools' url='https://github.com/techtribeone/iac/docker/iac' \
  vendor='techtribeone' version='0.1'

RUN \
apk -Uuv add \
  ansible \
  packer \
  terraform && \
rm -f /var/cache/apk/* && \
python3 -m pip install virtualenv
