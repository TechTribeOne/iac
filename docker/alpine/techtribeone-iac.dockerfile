FROM techtribeone/alpine-cli

LABEL \
  com.techtribeone.maintainer='sean conley <sean.conley@techtribeone.com>' \
  com.techtribeone.vendor='techtribeone' \
  license='MIT' name='iac' description='iac' url='https://github.com/techtribeone/iac/docker'

RUN \
apk -Uuv add \
  ansible \
  packer \
  terraform \
&& rm -f /var/cache/apk/* \
&& python3 -m pip install git+https://github.com/vmware/vsphere-automation-sdk-python.git \
&& mkdir -p /usr/share/ansible/collections \
&& ansible-galaxy collection install -p /usr/share/ansible/collections community.vmware \
&& rm -rf /root/.ansible /root/.cache
