FROM alpine:latest AS production

WORKDIR /root

EXPOSE 80

ENTRYPOINT [ "dumb-init", "--" ]

CMD [ "/usr/sbin/httpd", "-DFOREGROUND" ]

RUN apk add composer dumb-init icu-data-full php81-apache2 php81-gd php81-imap php81-intl php81-mysqli php81-pecl-imagick php81-pecl-redis php81-pecl-memcached php81-sockets php81-xml php81-zip tzdata

RUN wget https://github.com/RamonSilva20/mapos/archive/refs/heads/master.zip && unzip master.zip && mv mapos-master htdocs && chmod 755 htdocs && chown -R apache: htdocs && rm -Rf /var/www/localhost/htdocs && mv htdocs /var/www/localhost/ && rm master.zip
