FROM techtribeone/stream9-cli

LABEL \
  com.techtribeone.maintainer='sean conley <sean.conley@techtribeone.com>' \
  com.techtribeone.vendor='techtribeone' \
  license='MIT' name='iac' description='iac' url='https://github.com/techtribeone/iac/docker'

RUN \
yum -y update && \
yum -y install yum-utils && \
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
yum -y install \
  ansible \
  packer \
  terraform && \
rm -rf /var/cache/dnf/* /var/cache/yum/* && \
pip install virtualenv
