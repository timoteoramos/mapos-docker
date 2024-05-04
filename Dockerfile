FROM alpine:3.19 AS production

WORKDIR /root

EXPOSE 80

ENTRYPOINT [ "dumb-init", "--" ]

CMD [ "/usr/sbin/httpd", "-DFOREGROUND" ]

RUN apk add composer dumb-init icu-data-full php82-apache2 php82-gd php82-imap php82-intl php82-mysqli php82-pecl-imagick php82-pecl-redis php82-pecl-memcached php82-sockets php82-tokenizer php82-xml php82-zip tzdata

RUN wget https://github.com/RamonSilva20/mapos/archive/refs/heads/master.zip && unzip master.zip && mv mapos-master htdocs && chmod 755 htdocs && chown -R apache: htdocs && rm -Rf /var/www/localhost/htdocs && mv htdocs /var/www/localhost/ && rm master.zip

RUN composer -d /var/www/localhost/htdocs update && composer -d /var/www/localhost/htdocs install --no-dev
