FROM php:alpine

RUN apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS &&\
    pecl install mongodb &&\
    mkdir -p /tmp/php-xhprof-extension && cd /tmp/php-xhprof-extension &&\
    curl -fsSL https://github.com/tideways/php-xhprof-extension/archive/v4.1.7.tar.gz | tar xzf - --strip-components=1 &&\
    phpize && ./configure && make && make install &&\
    apk del .phpize-deps &&\
    rm -fr /tmp/*

COPY --from=edyan/xhgui:latest /usr/local/src/xhgui/ /usr/local/src/xhgui/

RUN echo -e "extension=tideways.so\ntideways.auto_prepend_library=0" > /usr/local/etc/php/conf.d/tideways.ini

RUN echo -e "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini
