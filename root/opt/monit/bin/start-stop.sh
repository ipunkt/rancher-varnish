#!/bin/sh
PIDFILE=/var/run/varnish.pid

case "$1"
	start)
		 start-stop-daemon --pidfile "${PIDFIILE}" -S /usr/sbin/varnishd \
			-b -P "${PIDFILE}"
		;;
	stop)
		 start-stop-daemon --pidfile "${PIDFIILE}" -K /usr/sbin/varnishd
		;;
esac
