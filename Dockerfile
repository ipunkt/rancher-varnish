FROM rawmind/alpine-monit:0.5.20-2

# Set environment
ENV SERVICE_NAME=varnish \
    SERVICE_HOME=/opt/varnish \
    SERVICE_VERSION=v1.1.1 \
    SERVICE_USER=varnish \
    SERVICE_UID=100 \
    SERVICE_GROUP=varnish \
    SERVICE_GID=101
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/monit/bin"

# Download and install traefik
RUN apk add --no-cache varnish openrc
COPY root /
RUN mkdir -p "$SERVICE_HOME/etc" && chown -R ${SERVICE_USER}:${SERVICE_GROUP} "$SERVICE_HOME" /opt/monit
COPY varnishd /etc/conf.d/

WORKDIR $SERVICE_HOME
USER $SERVICE_USER
