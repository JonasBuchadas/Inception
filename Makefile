include srcs/.env
export

up:
	mkdir -p /home/jocaetan/data/mysql
	mkdir -p /home/jocaetan/data/html
	docker compose -f srcs/docker-compose.yml up -d

up-recreate:
	mkdir -p /home/jocaetan/data/mysql
	mkdir -p /home/jocaetan/data/html
	docker compose -f srcs/docker-compose.yml up --force-recreate -d

down:
	docker compose -f srcs/docker-compose.yml down

test-wordpress:
	docker build -t test-wordpress srcs/requirements/wordpress
	docker run -it --rm --env-file srcs/.env test-wordpress bash
	docker rmi test-wordpress

test-mariadb:
	docker build -t test-mariadb srcs/requirements/mariadb
	docker run --rm --env-file srcs/.env test-mariadb
	docker rmi test-mariadb

enter-mariadb:
	docker exec -it mariadb-repo bash

enter-mariadb-outside-container:
	@mysql -h $(shell docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(MARIADB_HOST)) -u $(MARIADB_USER) -p$(MARIADB_USER_PASS) $(MARIADB_NAME)

ps:
	docker compose -f srcs/docker-compose.yml ps

clear: clear-images clear-volumes

clear-volumes:
	docker volume rm srcs_db srcs_wp

clear-containers:
	docker rm nginx-server mariadb-repo wordpress-site

clear-images:
	docker rmi nginx-server mariadb-repo wordpress-site

clear-cache:
	docker buildx prune
