FROM alpine:latest

# Install dependencies
RUN apk add --no-cache --update \
    opendkim opendkim-utils \
    bash syslog-ng

VOLUME [ "/etc/dkimkeys" ]

EXPOSE 8891/tcp

COPY files /
RUN chmod 0755 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["opendkim", "-f"]