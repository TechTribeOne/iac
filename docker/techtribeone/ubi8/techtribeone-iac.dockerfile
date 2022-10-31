FROM techtribeone/ubi8-cli

LABEL \
  name='techtribeone/centos/iac' version='0.1' license='MIT' \
  description='tools for Infrastructure as Code (IaC)' \
  url='https://github.com/techtribeone/iac/docker/iac' \
  vendor='techtribeone' maintainer='sean conley <sean.conley@techtribeone.com>'

RUN \
yum -y update && \
yum -y install yum-utils && \
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
yum -y install \
  packer \
  terraform && \
rm -rf /var/cache/dnf/* /var/cache/yum/* && \
pip -q install virtualenv ansible
