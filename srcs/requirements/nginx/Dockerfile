FROM debian:bookworm

RUN  apt-get  update  && apt-get  install gcc make  && \
 apt-get  install libpcre3-dev zlib1g-dev && apt-get  install libssl-dev

copy conf/nginx.conf /nginx/nginx/

RUN apt-get install nginx  && systemctl start nginx
 