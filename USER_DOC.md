
**What services are provided?**
- Nginx → Web server (handles HTTPS requests)
- WordPress → Website content management system (CMS)
- MariaDB → Database used by WordPress
- User → Nginx (HTTPS) → WordPress (PHP-FPM) → MariaDB (database)

***How to start the project?***
- to build image by docker compose  `make build `
- to start services ` make up `

***How to stop the project?***

- to stop contianer  ` make down `
- to clean every things ` make clean `

**How to access the website?**  

- https://zel-yama.42.fr
- https://zel-yama.42.fr/wp-admin
- open .env and take Credentials

**How to check if services are running?**

- docker ps 


