
FROM debian:bookworm 

RUN apt-get update  && apt-get upgrade 

RUN apt-get install -y php   php-mysql \
                 php-fpm \
                 curl \
                 tar
        

RUN mkdir -p /srv/www/wordpress && chown -R www-data:www-data /srv/www/wordpress && \
        curl https://wordpress.org/latest.tar.gz -o wordpress.tar.gz \
        && tar -zxf wordpress.tar.gz  -C /srv/www/wordpress && rm -r wordpress.tar.gz
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp


WORKDIR  /srv/www/wordpress/wordpress 

COPY ./tools/setUp.sh .



RUN chmod +x setUp.sh 

CMD ["bash", "/srv/www/wordpress/wordpress/setUp.sh"]


