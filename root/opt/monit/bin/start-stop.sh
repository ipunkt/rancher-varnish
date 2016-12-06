#!/bin/bash
PIDFILE=/opt/varnish/run/varnish.pid
BIND=${BIND_ADDRESS:0.0.0.0}
PORT=${PORT:8080}
CONFIG_FILE=${VARNISH_CONFIG:/opt/varnish/etc/default.vcl}
SECRET_FILE=${VARNISH_SECRET:/opt/varnish/etc/secret}

case "$1" in
	start)
		 start-stop-daemon --pidfile "${PIDFIILE}" -S /usr/sbin/varnishd \
			-a ${BIND}:${PORT} -P "${PIDFILE}" -T "127.0.0.1:8062" -f "${CONFIG_FILE}"
		;;
	stop)
		 start-stop-daemon --pidfile "${PIDFIILE}" -K /usr/sbin/varnishd
		;;
esac
