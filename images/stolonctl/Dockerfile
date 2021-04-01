FROM quay.io/gravitational/debian-grande:buster

ADD bin/stolonctl entrypoint.sh fix-permissions.sh pre-update.sh /usr/bin/
RUN chmod +x /usr/bin/stolonctl && \
    chmod +x /usr/bin/entrypoint.sh && \
    chmod +x /usr/bin/fix-permissions.sh && \
    chmod +x /usr/bin/pre-update.sh && \
    useradd -ms /bin/bash stolon -u 65533

USER stolon
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
