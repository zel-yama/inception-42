FROM debian:bookworm

 
RUN apt-get update -y  &&   apt-get install nginx -y && apt-get upgrade -y && apt-get  install -y openssl

COPY conf/nginx.conf /etc/nginx/nginx.conf

             
                     
RUN mkdir -p /etc/ssl/nginx && chmod 760 /etc/ssl/nginx &&  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/ssl/nginx/nginx.crt -keyout \
/etc/ssl/nginx/nginx.key -subj "/C=MA/ST=khouribga/L=khouribga/O=42/OU=Inception/CN=zel-yama.42.fr" 
# chown -R www-data:www-data /srv/www/html

EXPOSE 443
ENTRYPOINT ["nginx", "-g", "daemon off;"]
