name = inception

# Target to launch the configuration
all:
	@printf "Starting the ${name} setup...\n"
	@bash requirements/wordpress/tools/dir_build.sh
	@docker-compose -f ./docker-compose.yml --env-file ./.env up -d

# Target to build the configuration
build:
	@printf "Initiating build for the ${name} configuration...\n"
	@bash requirements/wordpress/tools/dir_build.sh
	@docker-compose -f ./docker-compose.yml --env-file ./.env up -d --build

# Target to stop the configuration
down:
	@printf "Halting the ${name} configuration...\n"
	@docker-compose -f ./docker-compose.yml --env-file ./.env down

# Target to rebuild the configuration (stop and then build)
re: down
	@printf "Rebuilding the ${name} configuration...\n"
	@docker-compose -f ./docker-compose.yml --env-file ./.env up -d --build

# Target to clean the configuration (stop and remove containers, prune Docker system)
clean: down
	@printf "Cleaning up the ${name} configuration...\n"
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

# Target to completely clean the configurations (stop all containers, prune all resources)
fclean:
	@printf "Performing a full cleanup of all Docker configurations...\n"
	@docker stop $$(docker ps -qa) || true
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY: all build down re clean fclean
