FROM rawmind/alpine-monit:0.5.20-2

# Set environment
ENV SERVICE_NAME=varnish \
    SERVICE_HOME=/opt/varnish \
    SERVICE_VERSION=v1.1.1 \
    SERVICE_USER=varnish \
    SERVICE_UID=100 \
    SERVICE_GROUP=varnish \
    SERVICE_GID=101
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/monit/bin:/opt/varnish/bin/"
ENV QUERYSTRING_VERSION=0.5

# Download and install varnish
RUN apk add --no-cache varnish varnish-dev openrc alpine-sdk autoconf automake \
	libtool python py-docutils
COPY root /
RUN mkdir -p "$SERVICE_HOME/run" && chown -R ${SERVICE_USER}:${SERVICE_GROUP} "$SERVICE_HOME" /opt/monit
COPY varnishd /etc/conf.d/

#ADD https://github.com/Dridi/libvmod-querystring/releases/download/v${QUERYSTRING_VERSION}/vmod-querystring-${QUERYSTRING_VERSION}.tar.gz /tmp/vmod-querystring-${QUERYSTRING_VERSION}.tar.gz
ADD https://github.com/Dridi/libvmod-querystring/archive/v0.5.tar.gz /tmp/vmod-querystring-${QUERYSTRING_VERSION}.tar.gz
RUN mkdir -p /usr/src \
	&& cd /usr/src \
	&& tar -xzf /tmp/vmod-querystring-${QUERYSTRING_VERSION}.tar.gz \
	&& ls \
	#&& cd vmod-querystring-${QUERYSTRING_VERSION} \
	&& cd libvmod-querystring-${QUERYSTRING_VERSION} \
	# && ./bootstrap \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make check \
	&& make install

WORKDIR $SERVICE_HOME
USER $SERVICE_USER
