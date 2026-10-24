ARG VERSION=latest
FROM timberio/vector:${VERSION}-alpine

COPY init-geoip.sh /usr/local/bin/init-geoip.sh
RUN chmod +x /usr/local/bin/init-geoip.sh

ENTRYPOINT ["/usr/local/bin/init-geoip.sh"]
CMD ["vector"]