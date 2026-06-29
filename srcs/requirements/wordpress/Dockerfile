
FROM debian:bookworm 



RUN apt-get update -y  && apt-get upgrade -y &&  apt-get install -y php   \
                 php-fpm \
                 curl \
                 tar \
                 iputils-ping php-mysqli \
                 mariadb-client                                  
        
 
      
       
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp  

COPY ./tools/setUp.sh /

ENTRYPOINT ["bash",  "./setUp.sh"]


