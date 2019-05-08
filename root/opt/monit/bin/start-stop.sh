#!/bin/bash
PIDFILE=/opt/varnish/run/varnish.pid
BIND=${BIND_ADDRESS:=0.0.0.0}
PORT=${PORT:=8080}
CONFIG_FILE=${VARNISH_CONFIG:=/opt/varnish/etc/default.vcl}
SECRET_FILE=${VARNISH_SECRET:=/opt/varnish/etc/secret}
STORAGE_BACKEND=${STORAGE_BACKEND:=malloc,256m}

case "$1" in
	start)
		 echo start-stop-daemon --pidfile "${PIDFILE}" -S /usr/sbin/varnishd -- \
			-a ${BIND}:${PORT} -s "${STORAGE_BACKEND}" -S "${SECRET_FILE}" -P "${PIDFILE}" \
			-T "127.0.0.1:6082" -f "${CONFIG_FILE}"
		 start-stop-daemon --pidfile "${PIDFILE}" -S /usr/sbin/varnishd -- \
			-a ${BIND}:${PORT} -S "${SECRET_FILE}" -P "${PIDFILE}" \
			-T "127.0.0.1:6082" -s "${STORAGE_BACKEND}" -f "${CONFIG_FILE}"
		;;
	stop)
		 start-stop-daemon --pidfile "${PIDFILE}" -K /usr/sbin/varnishd
		;;
esac
