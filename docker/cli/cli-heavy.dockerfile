FROM slconley/cli:1.1

LABEL maintainer='sean conley <slconley@gmail.com>' license='MIT' name='CLI-HEAVY'\
  description='All the CLIs, all in one place' url='https://github.com/slconley/docker' \
  vendor='slconley' version='1.1'

# installs AWS, PCF and OpenShift CLI's

RUN \
apk -Uuv add kubernetes@testing && \
pip install --upgrade pip awscli aws-amicleaner future wheel &&  \
cd /bin && \
curl -skL 'https://cli.run.pivotal.io/stable?release=linux64-binary&source=github' | tar -xz && \
curl -skL 'https://github.com/openshift/origin/releases/download/v3.10.0/openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz' | tar -xz --strip-components=1 && \
chmod 755 cf oc && \
chown root:root cf oc && \
rm /var/cache/apk/* && \
echo done

VOLUME ["/workspace"]
WORKDIR /workspace
