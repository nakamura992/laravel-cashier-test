default:
	@echo "command list:"
	@echo " make mig            - php artisan migrate"
	@echo " make mig-roll       - php artisan migrate:rollback"
	@echo " make mig-status     - php artisan migrate:status"
	@echo " make seed           - php artisan db:seed"
	@echo " make tinker         - php artisan tinker"
	@echo " make test           - php artisan test"
	@echo " make cache-clear    - php artisan cache:clear"
	@echo " make m-mig          - php artisan make:migration"
	@echo " make a-mig          - php artisan make:migration --table=table_name"
	@echo " make c-mig          - php artisan make:migration --table=table_name"
	@echo " make m-model        - php artisan make:model"
	@echo " make m-model-mig    - php artisan make:model -m"
	@echo " make m-rule         - php artisan make:rule"
	@echo " make m-ctrl         - php artisan make:controller"

mig:
	php artisan migrate

mig-roll:
	php artisan migrate:rollback

mig-status:
	php artisan migrate:status

seed:
	php artisan db:seed

tinker:
	php artisan tinker

test:
	php artisan test

cache-clear:
	php artisan cache:clear

m-mig:
	@read -p " Enter migration name: " name; \
	php artisan make:migration create_$${name}_table

a-mig:
	@read -p " Enter column name: " column; \
	read  -p " Enter table name:  " table; \
	php artisan make:migration add_$${column}_to_$${table}_table --table=$${table}

c-mig:
	@read -p " Enter column name: " column; \
	read  -p " Enter table name:  " table; \
	php artisan make:migration change_$${column}_in_$${table}_table --table=$${table}

m-model:
	@read -p " Enter model name: " name; \
	php artisan make:model $$name

m-model-mig:
	@read -p " Enter model name: " name; \
	php artisan make:model $$name -m

m-rule:
	@read -p " Enter rule name: " name; \
	php artisan make:rule $$name

m-ctrl:
	@read -p " Enter controller name: " name; \
	php artisan make:controller $$name