NAME=inception
COMPOSE=docker-compose -f srcs/docker-compose.yml
ENV_FILE=srcs/.env
DOMAIN=$(shell grep DOMAIN_NAME $(ENV_FILE) | cut -d '=' -f2)

all: up

up:
	@echo "\n🚀 Starting containers..."
	@$(COMPOSE) up --build -d

down:
	@echo "\n🛑 Stopping and removing containers..."
	@$(COMPOSE) down

re: down up

fclean:
	@echo "\n🔥 Full cleanup: volumes, containers, networks..."
	@$(COMPOSE) down -v --remove-orphans
	@docker volume rm $(shell docker volume ls -qf dangling=true) 2>/dev/null || true
	@docker rmi $(shell docker images -q --filter=reference='*inception*') 2>/dev/null || true

clean: down

certs:
	@echo "\n🔐 Generating SSL certificates..."
	@bash srcs/requirements/nginx/tools/setup.sh $(DOMAIN)

.PHONY: all up down re clean fclean certs
