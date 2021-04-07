ARG PGVERSION=12
# base build image
FROM quay.io/gravitational/debian-venti:go1.15.10-buster AS builder
ARG STOLON_REVISION=920fe4b83c158a6fe496dd6427a3715b84c0b4e2

ENV REPO_PATH=/gopath/src/github.com/sorintlab/stolon
RUN set -eux; \
    apt-get update && \
    apt-get install -qq -y git && \
    git clone https://github.com/gravitational/stolon.git $REPO_PATH && \
    cd $REPO_PATH && git checkout $STOLON_REVISION

WORKDIR $REPO_PATH

RUN mkdir -p bin && \
    CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags '-s' -o bin/stolon-sentinel ${REPO_PATH}/cmd/sentinel && \
    CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags '-s' -o bin/stolon-proxy ${REPO_PATH}/cmd/proxy && \
    CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags '-s' -o bin/stolonctl ${REPO_PATH}/cmd/stolonctl && \
    go build -a -installsuffix cgo -ldflags '-s' -o bin/stolon-keeper ${REPO_PATH}/cmd/keeper

FROM quay.io/gravitational/debian-grande:buster AS downloader
ARG PGMETRICS_VERSION=1.10.5
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

COPY --from=builder /gopath/src/github.com/sorintlab/stolon/bin/ /usr/local/bin
COPY --from=downloader /pgmetrics /usr/local/bin

RUN chmod +x /usr/local/bin/stolon-keeper /usr/local/bin/stolon-sentinel /usr/local/bin/stolon-proxy /usr/local/bin/stolonctl

EXPOSE 5432

USER stolon

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/local/bin/run.sh"]
