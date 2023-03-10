FROM techtribeone/centos7-cli

LABEL \
  com.techtribeone.maintainer='sean conley <sean.conley@techtribeone.com>' \
  com.techtribeone.vendor='techtribeone' \
  license='MIT' name='iac' description='iac' url='https://github.com/techtribeone/iac/docker'

RUN \
yum -y update \
&& yum -y install yum-utils \
&& yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo \
&& yum -y install \
  ansible \
  packer \
  terraform \
&& ansible-galaxy collection install -p /usr/share/ansible/collections community.vmware \
&& ansible-galaxy collection install -p /usr/share/ansible/collections vmware.vmware_rest \
&& for r in /usr/share/ansible/collections/ansible_collections/*/*/requirements.txt; do python3 -m pip install -qr $r; done || true \
&& rm -rf /var/cache/dnf/* /var/cache/yum/* /tmp/* /var/tmp/* \
