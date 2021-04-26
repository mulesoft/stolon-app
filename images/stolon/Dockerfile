ARG PGVERSION=12
# base build image
FROM quay.io/gravitational/debian-venti:go1.16.3-buster AS builder
ARG STOLON_REVISION=v0.16.0

ENV REPO_PATH=/stolon
RUN set -eux; \
    apt-get update && \
    apt-get install -qq -y git && \
    git clone https://github.com/sorintlab/stolon.git $REPO_PATH && \
    cd $REPO_PATH && git checkout $STOLON_REVISION

WORKDIR $REPO_PATH

RUN make

FROM quay.io/gravitational/debian-grande:buster AS downloader
ARG PGMETRICS_VERSION=1.7.0
RUN apt-get update && apt-get install wget -yqq && \
    wget https://github.com/rapidloop/pgmetrics/releases/download/v${PGMETRICS_VERSION}/pgmetrics_${PGMETRICS_VERSION}_linux_amd64.tar.gz && \
    tar xvf pgmetrics_${PGMETRICS_VERSION}_linux_amd64.tar.gz && \
    cp pgmetrics_${PGMETRICS_VERSION}_linux_amd64/pgmetrics /pgmetrics

#######
####### Build the final image
#######
FROM postgres:$PGVERSION

ADD rootfs/ /

RUN apt-get update && \
    apt-get install dumb-init jq -yqq && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        ~/.bashrc \
        /usr/share/doc/ \
        /usr/share/doc-base/ \
        /usr/share/man/ \
        /tmp/* && \
    chmod a+rx /usr/local/bin/run.sh && \
    chmod a+rx /usr/local/bin/stolon-security.sh && \
    chmod a+rx /usr/local/bin/update-secret.sh && \
    useradd -ms /bin/bash stolon -u 65533

EXPOSE 5432

COPY --from=builder /stolon/bin/ /usr/local/bin
COPY --from=downloader /pgmetrics /usr/local/bin

RUN chmod +x /usr/local/bin/stolon-keeper /usr/local/bin/stolon-sentinel /usr/local/bin/stolon-proxy

EXPOSE 5431 5432 6431

USER stolon

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/local/bin/run.sh"]
