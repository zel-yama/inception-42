FROM debian:bookworm

RUN apt-get update -y  && apt-get upgrade -y

RUN apt-get install mariadb-server -y 



COPY tools/set.sh /
RUN chmod +x set.sh 

CMD ["./set.sh"]



