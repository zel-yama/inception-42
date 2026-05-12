FROM debian:bookworm

 
RUN apt-get update &&   apt-get install nginx -y && apt-get upgrade 

COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN apt-get  install -y openssl  
             
                     
RUN mkdir -p /etc/ssl/nginx &&  openssl req -x509 -nodes -days 365 -newkey rsa:2054 -out /etc/ssl/nginx/nginx.crt -keyout \
/etc/ssl/nginx/nginx.key -subj "/C=MA/ST=khouribga/L=khouribga/O=42/OU=Inception/CN=zel-yama.42.fr" &&  \
mkdir -p  /srv/www/html && chown -R www-data:www-data /srv/www/html

EXPOSE 443
ENTRYPOINT ["nginx", "-g", "daemon off;  "]

