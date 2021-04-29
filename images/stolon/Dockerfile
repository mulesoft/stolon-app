# base build image
ARG GOLANG_VERSION
ARG PGVERSION

FROM quay.io/gravitational/debian-venti:go${GOLANG_VERSION}-buster AS builder
ARG STOLON_REVISION

ENV REPO_PATH=/stolon
WORKDIR $REPO_PATH
RUN set -eux; \
    apt-get update && \
    apt-get install -qq -y git && \
    git clone https://github.com/sorintlab/stolon.git $REPO_PATH --depth=1 --branch $STOLON_REVISION && \
    make

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
    apt-get install dumb-init -yqq && \
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

EXPOSE 5432

USER stolon

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/local/bin/run.sh"]
