FROM rawmind/alpine-monit:0.5.20-2

# Set environment
ENV SERVICE_NAME=varnish \
    SERVICE_HOME=/usr/local \
    SERVICE_VERSION=v1.1.1 \
    SERVICE_USER=varnish \
    SERVICE_UID=10001 \
    SERVICE_GROUP=varnish \
    SERVICE_GID=10001
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/monit/bin"

# Download and install traefik
RUN apk add --no-cache varnish
COPY root /
RUN chown -R ${SERVICE_USER}:${SERVICE_GROUP} /opt/monit && chmod +x /opt/monit/bin
COPY varnishd /etc/conf.d/

USER $SERVICE_USER
WORKDIR $SERVICE_HOME

