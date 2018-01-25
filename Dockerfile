FROM php:7-apache

ARG ROMA_BUILD_HOME=/var/roma_build
ENV WWW_HOME=/var/www/html

RUN apt-get update \
    && apt-get --yes --force-yes --no-install-recommends install unzip zip libxslt-dev curl libcurl3 libcurl3-dev

WORKDIR ${ROMA_BUILD_HOME}
COPY . .
RUN make dist \
    && unzip tei-roma-*.zip -d ${WWW_HOME}/ \
    && mv ${WWW_HOME}/tei-roma/roma/config-dist.php ${WWW_HOME}/tei-roma/roma/config.php \
    && docker-php-ext-install xsl \
    && docker-php-ext-install curl
