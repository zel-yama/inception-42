FROM debian:bookworm

RUN  apt-get  update  && apt-get  install gcc make  && \
 apt-get  install libpcre3-dev zlib1g-dev && apt-get  install libssl-dev

RUN apt-get install nginx  && cd nginx && auto/configure && \
 make 