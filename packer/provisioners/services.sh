#!/usr/bin/env bash

set -x

PATH="/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin"
DATE="$(/bin/date -u '+%Y%m%d.%H%M')"

cloudwatch_agent_rpm_url="https://s3.amazonaws.com/amazoncloudwatch-agent/centos/amd64/latest/amazon-cloudwatch-agent.rpm"
ssm_agent_rpm_url="https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm"


# --------------------------------------------------------------------------------------------------------------
# chrony
yum -y install chrony
systemctl enable chronyd
echo "server 169.254.169.123 prefer iburst" >> /etc/chrony.conf

# --------------------------------------------------------------------------------------------------------------
# syslog
yum -y install rsyslog
systemctl enable rsyslog
echo "*.* $insight_collector_target" > /etc/rsyslog.d/insight.conf
echo '$PreserveFQDN on' > /etc/rsyslog.d/custom.conf
systemctl restart rsyslog

# --------------------------------------------------------------------------------------------------------------
# logrotate (not really a service, but it sort of fits)
cat << EOF > /etc/logrotate.conf
compress
create
dateext
notifempty
rotate 4
weekly
minsize 4096
include /etc/logrotate.d
EOF

# --------------------------------------------------------------------------------------------------------------
# SSM agent install/config
# TODO:  investigate use of VPC endpoints: https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-setting-up-vpc.html
yum -y install $ssm_agent_rpm_url
systemctl enable amazon-ssm-agent

# --------------------------------------------------------------------------------------------------------------
# CloudWatch agent install/config
yum -y install collectd $cloudwatch_agent_rpm_url
systemctl enable amazon-cloudwatch-agent
# /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:AmazonCloudWatch-linux -s
