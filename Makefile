
up:
	cd srcs && docker compose up -d 
down:
	cd srcs && docker compose down 
build:
	cd srcs && docker compose build 
clean: 
	cd srcs && docker compose down  -v
