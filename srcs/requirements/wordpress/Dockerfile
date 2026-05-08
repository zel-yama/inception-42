
FROM debian:bookworm 

RUN apt-get upgrade -y && apt-get update -y 

RUN apt-get install php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip

RUN mkdir -p /srv/www/wordpress && chwon www-data /srv/www/wordpress && \
curl https://wordpress.org/latest.tar.gz \
&& tar -zxf wordpress.tar.gz  -C /srv/www/wordpress && rm wordpress.tar.gz



