FROM docker:stable as static-docker-source

FROM debian:buster

# SO Software
RUN apt update && apt install -y awscli wget unzip git vim curl make && apt clean all
RUN wget https://github.com/mozilla/sops/releases/download/v3.5.0/sops_3.5.0_amd64.deb \
    && dpkg -i sops_3.5.0_amd64.deb \
    && apt install -f \
    && rm sops_3.5.0_amd64.deb \
    && apt clean all

## Terraform
ENV PATH="/opt/tfenv/bin:$PATH"
RUN git clone --depth=1  https://github.com/tfutils/tfenv.git /opt/tfenv

## Helm
ENV HELMFILE_HELM3=1
COPY --from=alpine/helm:3.1.0 /usr/bin/helm /usr/local/bin/helm
COPY --from=quay.io/roboll/helmfile:helm3-v0.99.1 /usr/local/bin/helmfile /usr/local/bin/helmfile
RUN helm plugin install https://github.com/databus23/helm-diff --version master
RUN helm plugin install https://github.com/futuresimple/helm-secrets
RUN helm plugin install https://github.com/hypnoglow/helm-s3.git
RUN helm plugin install https://github.com/aslafy-z/helm-git.git

## KUBECTL
COPY --from=bitnami/kubectl:1.15 /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl-1.15
COPY --from=bitnami/kubectl:1.14 /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl-1.14
COPY --from=bitnami/kubectl:1.12 /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl-1.12
RUN cp /usr/local/bin/kubectl-1.15 /usr/local/bin/kubectl

## KUSTOMIZE
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
RUN mv kustomize /usr/local/bin/kustomize

## KUBEVAL
ADD https://github.com/instrumenta/kubeval/releases/download/0.14.0/kubeval-linux-amd64.tar.gz /tmp/
RUN tar zxvf /tmp/kubeval-linux-amd64.tar.gz kubeval && mv kubeval /usr/local/bin/kubeval
ADD schemas.tar.gz /opt/

## AWS-AUTH
ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.9/2019-06-21/bin/linux/amd64/aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
RUN chmod +x /usr/local/bin/aws-iam-authenticator

# Google SDK
ENV CLOUD_SDK_VERSION=280.0.0
COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker
RUN apt-get -qqy update && apt-get install -qqy \
    curl \
    gcc \
    python-dev \
    python-setuptools \
    apt-transport-https \
    lsb-release \
    openssh-client \
    git \
    gnupg python-pip && \
    pip install -U crcmod   && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 &&\
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    apt clean all
