
up:
	mkdir -p /home/zel-yama/data/mariadb
	mkdir -p /home/zel-yama/data/wordpress
	cd srcs && docker compose up -d
down:
	cd srcs && docker compose down 
build:
	cd srcs && docker compose build 
clean: 
	cd srcs && docker compose down  -v --rmi all
re: clean
	cd srcs && docker compose build --no-cache && docker compose up -d 