#!/bin/bash -e

# the hardening scripts somehow seem to undo the kernel params, so make sure this script is run _after_ hardening/apply.sh
grubby --grub2 --update-kernel=ALL --args="audit=1 fips=1 user_namespace.enable=1 namespace.unpriv_enable=1 namespace.max_user_namespaces=14320"

yum install -y dracut-fips dracut-fips-aesni
dracut -f -v
[[ -x /bin/prelink ]] && {
  echo <<-EOF > /etc/sysconfig/prelink
PRELINKING=no
EOF
  prelink -u -a
} || true
