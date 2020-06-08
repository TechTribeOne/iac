#!/bin/bash

# TODO:
#   skipping full re-hardening below so we can regain visibility about specific hardening that must be done post-launch .
#   a better approach would be have a hardening service that continuously manages the finds that occur over the life of an instance.

# hardening - round #1
# cd /root/packer/hardening
# ./apply.sh

# hardening - round #2
# /root/packer/sectool/sectool_secure_el7

# get current cloudwatch agent config and restart
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config \
  -m ec2 -c ssm:AmazonCloudWatch-linux -s

# remove firstboot now that it has run once
systemctl disable firstboot
rm -f /etc/systemd/system/firstboot.service
systemctl daemon-reload
systemctl reset-failed

# we're done
exit 0
