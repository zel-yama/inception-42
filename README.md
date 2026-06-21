
*This project has been created as part of the 42 curriculum by zel-yama.*
# Description
 
 **inception**   The goal of this project is to help you understand Docker administration and Docker Compose through the creation of a multi-container architecture.
It introduces container management, networking between services, persistent storage, and the orchestration of multiple applications using Docker Compose.


# Instructions

- first to build images ` make build `
- second to create containers ` make up`
- the last to remove containers ` make down`



# Resources 

### wordpress

- https://make.wordpress.org/cli/handbook/how-to/how-to-install/
- https://humayunahmed8.medium.com/installing-wordpress-using-command-line-interface-cli-d478d346b599
- https://ubuntu.com/tutorials/install-and-configure-wordpress#6-configure-wordpress-to-connect-to-the-database
- https://www.youtube.com/watch?v=I--CJFDxbjw&list=PLT9miexWCpPV7EfmKOp2JWyR7GqRHSHtc&index=4

### nginx 
- https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-plus/
- https://www.youtube.com/watch?v=j9QmMEWmcfo
- https://www.youtube.com/watch?v=AlE5X1NlHgg
- https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04 


### mariadb 
- https://mariadb.com/docs/server/mariadb-quickstart-guides/mariadb-connection-troubleshooting-guide
- https://www.scribd.com/document/813209878/Database-Server

### docker 
- https://docs.docker.com/reference/compose-file/
- https://dev.to/doziestar/a-comprehensive-guide-to-docker-volumes-4d9h



**AI usage** 
- I used AI to help me debug new and complex Docker errors that were difficult to understand at first.  
- It also helped me break down hard concepts into simpler explanations so I could understand them more easily.   
- In addition, I used AI to search for and collect learning resources related to Docker and Docker Compose. 
- help for wirting readme files 

**Virtual Machines vs Docker**
- Virtual Machines include a full operating system with their own kernel, while Docker containers share the host OS kernel.
- VMs are heavier and slower because they virtualize hardware, while Docker is lightweight and starts quickly.
- Each VM runs in complete isolation, but containers isolate only processes using Linux features like namespaces and cgroups.
- VMs are used for running different operating systems, while Docker is mainly used for deploying and scaling applications efficiently.

**Docker Network vs Host Network**
- Docker bridge networks give each container its own isolated network with a private IP address managed by Docker.
- Host network mode removes isolation and lets the container use the host machine’s network directly.
- Bridge networks require port mapping to access services from outside, while host network exposes ports directly.
- Bridge mode is safer and more common, while host mode is faster but less isolated.

**Secrets vs Environment Variable**
- Environment variables are simple key–value pairs passed to an application at runtime and are often visible inside the container or process.
- Secrets are designed to store sensitive data like passwords, API keys, and tokens in a more secure way.
- Environment variables can be exposed or logged more easily, while secrets are usually encrypted and access-controlled.
- Secrets are preferred for security-sensitive information, while environment variables are used for general configuration

**Docker Volumes vs Bind Mounts**
- Docker volumes are managed by Docker and stored in Docker’s internal storage, making them more portable and safer.
- Bind mounts directly link a folder from the host machine into the container filesystem.
- Volumes are preferred for production because Docker controls their lifecycle, while bind mounts are often used for development.
- Bind mounts give direct access to host files, while volumes are more isolated and easier to manage across environments.

