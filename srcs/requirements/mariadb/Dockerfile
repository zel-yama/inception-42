FROM debian:bookworm

RUN apt-get update -y  && apt-get upgrade -y && apt-get install mariadb-server -y 

COPY tools/set.sh /

RUN chmod +x set.sh 

ENTRYPOINT ["./set.sh"]



