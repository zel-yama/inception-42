FROM debian:bookworm

 
RUN apt-get update &&   apt-get install nginx -y 

COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN apt-get  install openssl \
                     curl \
                     


RUN mkdir -p /etc/ssl/nginx &&  opnessl req -x509 -nodes -newkey ras:2054 -out /etc/ssl/nginx/nginx.key -kout \
/etc/ssl/nginx/nginx.crt 


ENTRYPOINT ["nginx", "-g", "demoen off "]