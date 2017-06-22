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
ENV VARNISH_VERSION=4.1.6 \
	QUERYSTRING_VERSION=1.0.2
	

# Download and install traefik
RUN apk add --no-cache \
	 gcc g++ python linux-headers py-docutils ncurses ncurses-dev pcre pcre-dev \
	libedit libedit-dev automake libtool m4 autoconf make \
	&& curl -sfL https://repo.varnish-cache.org/source/varnish-${VARNISH_VERSION}.tar.gz -o /tmp/varnish.tar.gz \
	&& mkdir -p /usr/local/src \
	&& cd /usr/local/src \
	&& tar -xzf /tmp/varnish.tar.gz \
	&& cd varnish-${VARNISH_VERSION} \
	&& sh autogen.sh \
	&& sh configure --prefix=/usr/ \
	#&& echo "#include <sys/stat.h>" > inc.patch \
	#&& cat inc.patch include/vpf.h > /tmp/vpf.h \
	#&& mv /tmp/vpf.h include/vpf.h \
	&& make \
	&& make check \
	&& make install \
	&& addgroup -S -g ${SERVICE_GID} ${SERVICE_GROUP} \
	&& adduser -S -u ${SERVICE_UID} -G ${SERVICE_GROUP} -D -h ${SERVICE_HOME} ${SERVICE_USER}

ADD https://github.com/Dridi/libvmod-querystring/releases/download/v1.0.2/vmod-querystring-1.0.2.tar.gz /tmp/vmod-querystring-1.0.2.tar.gz 
RUN cd /usr/local/src/ \
	&& tar -xzf /tmp/vmod-querystring-${QUERYSTRING_VERSION}.tar.gz \
	&& ls \
	&& cd vmod-querystring-${QUERYSTRING_VERSION} \
	&& ./configure --with-rst2man=: \
	&& make \
	&& make check \
	&& make install


COPY root /
RUN mkdir -p "$SERVICE_HOME/run" \
	&& chown -R ${SERVICE_USER}:${SERVICE_GROUP} "$SERVICE_HOME" /opt/monit
COPY varnishd /etc/conf.d/

WORKDIR $SERVICE_HOME
USER $SERVICE_USER
