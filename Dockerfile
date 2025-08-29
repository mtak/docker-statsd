FROM node:current

RUN npm install -g statsd@0.9.0

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x /docker-entrypoint.sh
RUN mkdir /opt/statsd
ENTRYPOINT ["/docker-entrypoint.sh"]
