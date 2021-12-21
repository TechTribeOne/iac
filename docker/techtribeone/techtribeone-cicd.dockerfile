FROM techtribeone/cli

LABEL maintainer='sean conley <sean.conley@techtribeone.com>' license='MIT' name='CICD'\
  description='CI/CD tools' url='https://github.com/techtribeone/iac/docker/cicd' \
  vendor='techtribeone' version='1.1'

RUN \
apk -Uuv --no-cache add \
  ansible \
  terraform
