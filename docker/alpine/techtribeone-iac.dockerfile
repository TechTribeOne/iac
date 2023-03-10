FROM techtribeone/alpine-cli

LABEL \
  com.techtribeone.maintainer='sean conley <sean.conley@techtribeone.com>' \
  com.techtribeone.vendor='techtribeone' \
  license='MIT' name='iac' description='iac' url='https://github.com/techtribeone/iac/docker'

RUN \
apk -Uuv add \
  packer \
  terraform \
&& python3 -m pip install -qU ansible \
&& ansible-galaxy collection install -p /usr/share/ansible/collections community.vmware \
&& ansible-galaxy collection install -p /usr/share/ansible/collections vmware.vmware_rest \
&& for r in /usr/share/ansible/collections/ansible_collections/*/*/requirements.txt; do python3 -m pip install -qr $r; done \
&& rm -rf /root/.ansible /root/.cache /tmp/* /var/tmp/* /var/cache/apk/* \
