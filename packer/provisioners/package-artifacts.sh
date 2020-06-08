#!/bin/bash

sshUserHome=$(eval cd ~${sshUser};pwd)
artifacts=$sshUserHome/artifacts

# exit clean if no artifacts
[ -d $artifacts ] || exit 0

# create zip of artifacts dir
base=$(basename $artifacts)
dir=$(dirname $artifacts)
cd $dir
zip -ro ${base}.zip $base 
chown $sshUser ${base}.zip
