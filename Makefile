NAME = inception
DATA_DIR = /tmp/inception_data

all: build

build:
	@echo "🐳 Building and starting containers..."
	@cd srcs && docker-compose up -d --build

up:
	@echo "🐳 Starting containers..."
	@cd srcs && docker-compose up -d

down:
	@echo "🛑 Stopping containers..."
	@cd srcs && docker-compose down

stop:
	@echo "🛑 Stopping containers..."
	@cd srcs && docker-compose stop

restart: down up

logs:
	@cd srcs && docker-compose logs -f

clean: down
	@echo "🧹 Cleaning containers and images..."
	@docker system prune -af
	@docker volume prune -f

fclean: clean
	@echo "🗑️  Removing volumes..."
	@docker volume rm -f srcs_mariadb_data srcs_wordpress_data 2>/dev/null || true
	@docker system prune -af --volumes

re: fclean all

status:
	@echo "📊 Container status:"
	@docker ps
	@echo "\n💾 Volume status:"
	@docker volume ls
	@echo "\n🌐 Network status:"
	@docker network ls

shell-nginx:
	@docker exec -it nginx /bin/bash

shell-wordpress:
	@docker exec -it wordpress /bin/bash

shell-mariadb:
	@docker exec -it mariadb /bin/bash

.PHONY: all build up down stop restart logs clean fclean re status shell-nginx shell-wordpress shell-mariadb