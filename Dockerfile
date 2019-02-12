FROM php:7-apache

ARG ROMA_BUILD_HOME=/var/roma_build
ENV WWW_HOME=/var/www
ENV OXGARAGE_SERVER=http://oxgarage2.tei-c.org/ege-webservice
ENV ROMA_XQUERY_SERVER=http://www.tei-c.org/Query/
ENV ROMA_TEIWEB_SERVER=http://www.tei-c.org/release/doc/tei-p5-doc/

RUN apt-get update \
    && apt-get --yes --force-yes --no-install-recommends install unzip zip libxslt-dev curl libcurl3 libcurl3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR ${ROMA_BUILD_HOME}
COPY . .
RUN make dist OXGARAGE_SERVER=${OXGARAGE_SERVER} \
    && unzip tei-roma-*.zip -d ${WWW_HOME}/ \
    && mv ${WWW_HOME}/tei-roma/roma/config-dist.php ${WWW_HOME}/tei-roma/roma/config.php \
    && docker-php-ext-install xsl curl \
    && sed -i -e "s+${WWW_HOME}/html+${WWW_HOME}/tei-roma+" /etc/apache2/sites-enabled/000-default.conf \
    && chmod 755 docker-roma-entrypoint.sh

VOLUME ["/usr/share/xml/tei"]

CMD ["./docker-roma-entrypoint.sh"]
