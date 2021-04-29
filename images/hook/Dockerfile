FROM quay.io/gravitational/rig:7.0.4

ARG CHANGESET
ENV RIG_CHANGESET $CHANGESET

ADD update.sh /
ADD rollback.sh /

RUN chmod +x /update.sh && chmod +x /rollback.sh

ENTRYPOINT ["/usr/bin/dumb-init", "/update.sh"]
