#!/bin/bash -e

# hack for docker, until this lands in puppet baseline
echo "user.max_user_namespaces=14320" >> /etc/sysctl.conf

echo -n "Empty mail queue..."
postsuper -d ALL
echo "done"

echo -n "Removing AWS credentials..."
# this won't find /root/.aws, but thats indended (for now). We configure some things in earlier packer scripts
find /home -type d -name '.aws' -exec /bin/rm -rf {} \;
echo "done"

echo -n "Cleaning YUM..."
/bin/package-cleanup -q -y --oldkernels --count=1
yum -q -y remove puppet-agent puppetlabs-release-pc1
yum -y clean all > /dev/null
yum history sync > /dev/null
yum history new > /dev/null
echo "done"

#has it's own output
which gem > /dev/null && {
  gem cleanup
  gem sources -c
} || {
  echo "Skipping Gem cleanup because rubygems is not installed"
}

echo -n "Disable systemd services..."
{
  systemctl -q mask ctrl-alt-del.target
  systemctl -q disable kdump.service
  systemctl -q disable atd.service
} || true
echo "done"

echo -n "Cleaning filesystem..."
/bin/rm -rf /tmp/*
/bin/rm -rf /var/tmp/*
/bin/rm -rf /etc/puppetlabs
/bin/rm -rf /tmp/rpsxps
/bin/rm -rf /var/lib/cloud
/bin/rm -rf /tmp/ruby*
/bin/rm -f /var/log/audit/audit.log.*
/bin/rm -f /etc/puppetlabs/keys/*
/bin/rm -f /root/anaconda-ks.cfg
/bin/rm -f /etc/udev/rules.d/70-persistent-net.rules
/bin/rm -rf /root/hardening*
[[ -f /dev/xen/xenbus ]] && {
  chcon --type=device_t /dev/xen/xenbus
  semanage fcontext -a -t device_t "/dev/xen(/.*)?"
} || true
echo "done"

# using systemctl for auditd doesn't work ... https://access.redhat.com/solutions/1240243
auditctl -e 0 -f 0

unset HISTFILE

echo -n "Cleaning log files..."
systemctl -q stop rsyslog
find /var/log -type f -name '*-[0-9]*' -exec /bin/rm -f {} \;
cd /var/log
find /var/log/ -type f | xargs -L1 cp -f /dev/null
for toremove in /var/log/audit/audit.log /var/log/cloud-init* /root/.bash_history /home/admin911/.bash_history; do
  if [ -f ${toremove} ]; then cp -f /dev/null ${toremove};fi
done
echo "done"

echo -n "remove extraneous files/dir(s)..."
rm -Rf ~${sshUser}/*
echo "done"

echo -n "sanitize /var/log/messages..."
cat /dev/null > /var/log/messages
echo "done"

echo -n "clear network config UUIDs..."
/bin/sed -i '/^(HWADDR|UUID)=/d' /etc/sysconfig/network-scripts/ifcfg-e*
echo "done"

echo -n "remove ssh host keys..."
/bin/rm -rf /etc/ssh/ssh_host_*
/bin/rm -f /root/.ssh/known_hosts
echo "done"

echo -n "remove ssh user keys..."
for u in centos ec2-user admin911 root; do
  grep -q ${u} /etc/passwd && passwd -l ${u} > /dev/null
  rm -rf $(eval echo "~${u}")/.ssh/*
done
echo "done"

echo -n "Generating Baseline AIDE database..."
auditctl -e 0 -f 0
/usr/sbin/aide -V1 --init
[ -f /var/lib/aide/aide.db.new.gz ] && /bin/mv -f /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
echo "done"

echo "Zero-ing disks (this will take some time):"
for fs in $(findmnt -o TARGET -nlt xfs,ext3,ext4 --mtab); do
  echo -n "   ${fs}..."
  dd if=/dev/zero of=${fs}/zerofile bs=1M &>/dev/null || /bin/rm -f ${fs}/zerofile
  sleep 2
  /bin/sync
  echo "complete"
done
echo "done"

exit 0
