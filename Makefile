STAGE=dev

.DEFAULT_GOAL = help

.PHONY: help
help: ## Help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf " \033[36m%-20s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: tests
tests: ## Tests app
	docker-compose run app sh -c "python manage.py test && flake8"

.PHONY: migrations
migrations: ## Make migrations on the app specified through the argument
	docker-compose run app sh -c "python manage.py makemigrations ${appname}"

.PHONY: clean
clean: # Removes all *.pyc files
	rm -rf $(VENV)
	find . -type f -name '*.pyc' -delete

.PHONY: deps-install
deps-install: ## Installs the requirements file into virtual environment repo
	@echo "🛠Installing deps from requirements.txt🛠"
	@. $(VENV)/bin/activate; \
	pip install -r requirements.txt

.PHONY: lint
lint:  ## lints using flake8
	@echo "🔦 Code linted\n" \
		"  --- Level supreme"
	@. $(VENV)/bin/activate; \
	flake8 --verbose $(shell git ls-files '*.py')
