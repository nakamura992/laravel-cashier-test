command-list:
	@echo "command-list:"
	@echo " make build             - docker-compose build"
	@echo " make build-up          - docker-compose up -d --build"
	@echo " make nbuild            - docker-compose build --no-cache"
	@echo " make up                - docker-compose up -d"
	@echo " make down              - docker-compose down"
	@echo " make app               - docker-compose exec app bash"
	@echo " make app-www-data      - docker-compose exec --user=www-data app bash"
	@echo " make setup_for_mac     - Laravel setup for Mac/Linux"
	@echo " make setup_for_windows - Laravel setup for Windows"
	@echo " make init-build-up     - docker-compose -f docker-compose.init.yml up -d --build"
	@echo " make init-nbuild       - docker-compose -f docker-compose.init.yml build --no-cache"
	@echo " make init-up           - docker-compose -f docker-compose.init.yml up -d"
	@echo " make down -v           - docker-compose down -v"


# Docker commands
build:
	docker-compose build

build-up:
	docker-compose up -d --build

nbuild:
	docker-compose build --no-cache

up:
	docker-compose up -d

down:
	docker-compose down

app:
	docker-compose exec app bash

app-www-data:
	docker-compose exec --user=www-data app bash

down-v:
	docker-compose down -v

# Laravel setup for Mac/Linux
setup_for_mac:
	@read -p "Are you sure you want to continue? (yes/no) " choice; \
	if [ "$$choice" = "yes" ]; then \
		sh bin/sh/setup.sh; \
	else \
		echo "Setup cancelled."; \
	fi

# Laravel setup for Windows
setup_for_windows:
	@powershell -Command " \
		$$choice = Read-Host 'Are you sure you want to continue? (yes/no)'; \
		if ($$choice -eq 'yes') { \
			& '.\bin\bat\setup.bat'; \
		} else { \
			Write-Host 'Setup cancelled.' \
		}"

init-build-up:
	docker-compose -f docker-compose.init.yml up -d --build

init-nbuild:
	docker-compose -f docker-compose.init.yml build --no-cache

init-up:
	docker-compose -f docker-compose.init.yml up -d