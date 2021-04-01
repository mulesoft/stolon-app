FROM quay.io/gravitational/debian-grande:buster

ADD bin/stolonboot \
        /usr/local/bin/

ADD bootstrap.sh /bootstrap.sh
RUN chmod a+x /bootstrap.sh

CMD ["/bootstrap.sh"]
