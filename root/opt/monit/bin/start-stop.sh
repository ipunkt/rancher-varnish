#!/bin/sh
PIDFILE=/opt/varnish/run/varnish.pid

case "$1" in
	start)
		 start-stop-daemon --pidfile "${PIDFIILE}" -S /usr/sbin/varnishd \
			-b -P "${PIDFILE}"
		;;
	stop)
		 start-stop-daemon --pidfile "${PIDFIILE}" -K /usr/sbin/varnishd
		;;
esac
