#!/bin/bash
set -e

if [ "x$GRAPHITE_HOST" = "x" ]; then
  export GRAPHITE_HOST="localhost"
fi

if [ "x$GRAPHITE_PORT" = "x" ]; then
  export GRAPHITE_PORT="2003"
fi

if [ "x$STATSD_PORT" = "x" ]; then
  export STATSD_PORT="8125"
fi

if [ "x$DELETECOUNTERS" = "x" ]; then
  export DELETECOUNTERS="true"
fi

if [ "x$FLUSHINTERVAL" = "x" ]; then
  export FLUSHINTERVAL='10000'
fi

cat <<EOF >/opt/statsd/config.js
{
  graphitePort: "${GRAPHITE_PORT}",
  graphiteHost: "${GRAPHITE_HOST}",
  port: ${STATSD_PORT},
  deleteCounters: ${DELETECOUNTERS},
  flushInterval: ${FLUSHINTERVAL},
  graphite: {
    legacyNamespace: false,
  }
}
EOF

exec statsd /opt/statsd/config.js
