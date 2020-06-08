#! /bin/bash

curl -skL https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem -o /etc/pki/ca-trust/source/anchors/rds-combined-ca-bundle.pem
update-ca-trust extract
chmod 644 /etc/pki/ca-trust/source/anchors/*
