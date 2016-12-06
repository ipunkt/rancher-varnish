#!/bin/bash
PIDFILE=/opt/varnish/run/varnish.pid
BIND=${BIND_ADDRESS:=0.0.0.0}
PORT=${PORT:=8080}
CONFIG_FILE=${VARNISH_CONFIG:=/opt/varnish/etc/default.vcl}
SECRET_FILE=${VARNISH_SECRET:=/opt/varnish/etc/secret}

case "$1" in
	start)
		 echo start-stop-daemon --pidfile "${PIDFILE}" -S /usr/sbin/varnishd -- \
			-a ${BIND}:${PORT} -S "${SECRET_FILE}" -P "${PIDFILE}" \
			-T "127.0.0.1:8062" -f "${CONFIG_FILE}"
		 start-stop-daemon --pidfile "${PIDFILE}" -S /usr/sbin/varnishd -- \
			-a ${BIND}:${PORT} -S "${SECRET_FILE}" -P "${PIDFILE}" \
			-T "127.0.0.1:8062" -f "${CONFIG_FILE}"
		;;
	stop)
		 start-stop-daemon --pidfile "${PIDFILE}" -K /usr/sbin/varnishd
		;;
esac
