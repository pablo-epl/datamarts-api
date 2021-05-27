STAGE=dev
THIS_FILE := $(lastword $(MAKEFILE_LIST))

.NOTPARALLEL:

.DEFAULT_GOAL = help

.PHONY: help
help: ## Help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf " \033[36m%-20s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: build
build: ## Build a new image
	docker-compose build

.PHONY: compose-down
compose-down:
	docker-compose down

.PHONY: compose-up
compose-up:
	docker-compose up

.PHONY: tests
tests:
	docker-compose run app sh -c "python manage.py wait_for_db && python manage.py test && flake8"
	$(MAKE) -j1 compose-down

.PHONY: rmc
rmc:
	docker rm $(shell docker ps -a -q --filter="name=datamarts-api")

.PHONY: migrations
migrations: ## Make migrations on the app specified through the argument
	docker-compose run app sh -c "python manage.py makemigrations ${appname}"

.PHONY: clean
clean: # Removes all *.pyc files
	rm -rf $(VENV)
	find . -type f -name '*.pyc' -delete

.PHONY: lint
lint:  ## lints using flake8
	@echo "🔦 Code linted\n" \
		"  --- Level supreme"
	@. $(VENV)/bin/activate; \
	flake8 --verbose $(shell git ls-files '*.py')
