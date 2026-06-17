
FROM debian:bookworm 



RUN apt-get update -y  && apt-get upgrade -y &&  apt-get install -y php   php-mysql \
                 php-fpm \
                 curl \
                 tar \
                 iputils-ping php-mysqli php-phar php-mbstring php-tokenizer \
                php-xml php-zip mariadb-client                                  
        

RUN mkdir -p /srv/www/wordpress && chown -R www-data:www-data /srv/www/wordpress 
      
       
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp  

COPY ./tools/setUp.sh /

CMD ["bash",  "./setUp.sh"]


