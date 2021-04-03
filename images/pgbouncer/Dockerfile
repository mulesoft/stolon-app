ARG PGVERSION=11
FROM postgres:$PGVERSION

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        gettext \
        hostname \
        procps \
        dumb-init \
        pgbouncer \
        openssl && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        ~/.bashrc \
        /usr/share/doc/ \
        /usr/share/doc-base/ \
        /usr/share/man/ \
        /tmp/*

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ADD common_lib.sh /common_lib.sh

RUN useradd -ms /bin/bash -u 65533 stolon && \
    chmod +x /usr/local/bin/entrypoint.sh

ADD pgbouncer_auth.sql /home/stolon/pgbouncer_auth.sql

USER stolon
EXPOSE 6432
ENTRYPOINT ["dumb-init", "--", "/usr/local/bin/entrypoint.sh"]
