up:
	docker compose -f srcs/docker-compose.yml up

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

clear: clear-containers clear-images clear-volumes

clear-volumes:
	docker volume rm srcs_db srcs_wp

clear-containers:
	docker rm nginx-server mariadb-repo wordpress-site

clear-images:
	docker rmi nginx-server mariadb-repo wordpress-site
