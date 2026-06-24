
# DEV_DOC.md — Developer Documentation

This document explains how to set up, build, run, and maintain this project: a containerized **WordPress + MariaDB + Nginx** stack orchestrated with Docker Compose.

---

## 1. Architecture Overview

The stack is composed of three custom-built services connected through a single bridge network:

| Service    | Role                                  | Exposed Port | Depends on |
|------------|----------------------------------------|--------------|------------|
| `mariadb`  | Database for WordPress                 | internal only| —          |
| `wordpress`| PHP-FPM application (WordPress core)   | internal only| `mariadb`  |
| `nginx`    | Reverse proxy / TLS termination, only public entrypoint | `443` (HTTPS) | `wordpress`|

All three containers communicate over a private Docker bridge network called `inception`. Only `nginx` publishes a port to the host (`443`), so WordPress and MariaDB are never reachable directly from outside the host.

---

## 2. Prerequisites

Before setting this project up, make sure the following are installed on the host machine:

- **Docker Engine** (20.10+ recommended)
- **Docker Compose v2** (invoked as `docker compose`, not the legacy `docker-compose`)
- **make**


Verify your installation:

```bash
docker --version
docker compose version
make --version
```

---

## 3. Project Structure

```
.
├── Makefile
├── .env
└── srcs/
    └── requirements/
        ├── mariadb/
        │   └── Dockerfile        # builds the mariadb image
        ├── wordpress/
        │   └── Dockerfile        # builds the wordpress image
        └── nginx/
            └── Dockerfile        # builds the nginx image
```

Each service is built from its own `Dockerfile` under `srcs/requirements/<service>/`, rather than pulled from a public image — this is referenced in `docker-compose.yml` via the `build:` directive.

---

## 4. Environment Configuration (`.env`)

All secrets and environment-specific values are centralized in a single `.env` file at the project root. Both `mariadb` and `wordpress` containers load it via `env_file: - .env`.

### 4.1 Creating the `.env` file

This file is **not committed to version control** (it should be listed in `.gitignore`). Create it manually at the project root with the following variables:

```properties
# --- Database ---
DATABASE_NAME=data_base
MYSQL_USER=data_base_user
MYSQL_PASSWORD=data_password
MYSQL_ROOT_PASSWORD=root_data_pass

# --- Domain / WordPress ---
DOMAIN_NAME=login.42.fr
WORDPRESS_ADMIN_USER_NAME=wordPress_admin
WORDPRESS_PASSWORD=user_password
WORDPRESS_USER=user_wordpress
WORDPRESS_EMAIL_USER=user_wordpress@gmail.com
WORDPRESS_USER_PASSWORD=user_pass
EMAIL_ADMIN_WORDPRESS=admin_email@gmail.com
```

### 4.2 Variable reference

| Variable                     | Used by      | Purpose                                              |
|-------------------------------|--------------|-------------------------------------------------------|
| `DATABASE_NAME`               | mariadb      | Name of the WordPress database schema                 |
| `MYSQL_USER`                  | mariadb      | Non-root DB user (used by WordPress to connect)       |
| `MYSQL_PASSWORD`              | mariadb      | Password for `MYSQL_USER`                             |
| `MYSQL_ROOT_PASSWORD`         | mariadb      | Root password for the MariaDB instance                |
| `DOMAIN_NAME`                 | wordpress    | domain for wordpress web site                         |
| `WORDPRESS_ADMIN_USER_NAME`   | wordpress    | WordPress administrator login                          |
| `WORDPRESS_PASSWORD`          | wordpress    | WordPress administrator password                       |
| `WORDPRESS_USER`              | wordpress    | Secondary (non-admin) WordPress user                   |
| `WORDPRESS_USER_PASSWORD`     | wordpress    | Password for the secondary user                        |
| `WORDPRESS_EMAIL_USER`        | wordpress    | Email associated with the  user                        |
| `EMAIL_ADMIN_WORDPRESS`       | wordpress    | Email associated with the admin user                   |



---

## 5. Data Persistence & Volumes

Project data is **not** stored inside the containers — it is named_volume from the host so that it survives container removal/rebuilds.

### 5.1 Where data lives on the host

| Docker volume       | Host path                      | Mounted into        | Contains                          |
|----------------------|---------------------------------|----------------------|------------------------------------|
| `storage`            | `/home/zel-yama/data/mariadb`   | `mariadb:/var/lib/mysql`        | MariaDB database files            |
| `storage_wordpress`  | `/home/zel-yama/data/wordpress` | `wordpress:/srv/www/wordpress` and `nginx:/srv/www/wordpress` | WordPress core, themes, plugins, uploads |

Both volumes use the `local` driver with `bind` mount options (`driver_opts: type: none, o: bind, device: <host_path>`), meaning Docker does **not** manage these directories internally — they map directly to real folders on the host filesystem.

### 5.2 Before first launch

Since these are **bind mounts**, the host directories must exist beforehand or Docker will create them automatically (as root) on first run — it's good practice to create them yourself to ensure correct ownership:

```bash
mkdir -p /home/zel-yama/data/mariadb
mkdir -p /home/zel-yama/data/wordpress
```

### 5.3 Persistence behavior

- `docker compose down` — stops and removes containers, **data on the host persists** (volumes are not deleted).
- `docker compose down -v` (or `make clean`) — also removes the named volumes' references; since these are bind mounts, **the actual files on the host remain on disk** at the paths above. To fully wipe data, manually delete the host directories:
  ```bash
  sudo rm -rf /home/zel-yama/data/mariadb/* /home/zel-yama/data/wordpress/*
  ```

---

## 6. Build & Launch

A `Makefile` wraps the common Docker Compose operations.

### 6.1 Build the images

```bash
make build
```
Runs `docker compose build` — builds the `mariadb`, `wordpress`, and `nginx` images from their respective Dockerfiles in `srcs/requirements/`.

### 6.2 Start the stack

```bash
make up
```
Runs `docker compose up -d` — builds (if needed) and starts all three containers in detached mode, in dependency order: `mariadb` → `wordpress` → `nginx`.

Once running, the site is reachable at:
```
https://<DOMAIN_NAME>
```
(`DOMAIN_NAME` as defined in your `.env`, e.g. `https://zel-yama.42.fr`). You'll likely need a local hosts-file entry (`/etc/hosts`) pointing that domain to `127.0.0.1` if it's not a real public DNS record.

### 6.3 Stop the stack

```bash
make down
```
Runs `docker compose down` — stops and removes the containers and the `inception` network. **Host data is preserved.**

### 6.4 Full clean (containers + volumes)

```bash
make clean
```
Runs `docker compose down -v` — same as above, plus removes the named volumes' Docker-level references. As noted in [5.3](#53-persistence-behavior), actual host files survive this and must be deleted manually if you want a truly fresh start.

---

## 7. Useful Docker Compose Commands

Beyond the Makefile targets, these are handy during development:

| Command | Purpose |
|---|---|
| `docker compose ps` | List running containers and their status |
| `docker compose logs -f` | Stream logs from all services |
| `docker compose logs -f wordpress` | Stream logs from a single service |
| `docker compose exec mariadb bash` | Open a shell inside the `mariadb` container |
| `docker compose exec wordpress bash` | Open a shell inside the `wordpress` container |
| `docker compose restart nginx` | Restart a single service without rebuilding |
| `docker compose build --no-cache wordpress` | Force a clean rebuild of one image |
| `docker volume ls` | List Docker-managed volume references |
| `docker volume inspect storage` | Inspect bind-mount details (host path, driver opts) |
| `docker network inspect inception` | Inspect the shared bridge network and connected containers |

---

## 8. Troubleshooting Tips

- **WordPress can't connect to the database:** confirm `mariadb` is healthy (`docker compose logs mariadb`) and that `MYSQL_USER` / `MYSQL_PASSWORD` / `DATABASE_NAME` match what WordPress's `wp-config.php` expects — both are sourced from the same `.env`.
- **Site unreachable via `DOMAIN_NAME`:** check `/etc/hosts` for a local mapping, and confirm port `443` isn't already in use on the host (`sudo lsof -i :443`).
- **Stale data after rebuild:** if old WordPress/DB content persists unexpectedly after `make clean`, remember bind-mounted host data isn't deleted by `-v` — clear `/home/zel-yama/data/` manually (see [5.3](#53-persistence-behavior)).
- **Permission errors on volumes:** since these are root-owned bind mounts by default, you may need `sudo` to inspect or delete files under `/home/zel-yama/data/`.
