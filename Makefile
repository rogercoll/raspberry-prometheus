.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

all: init run

init: ## Init Ansible
	ansible-galaxy install -r requirements.yml --roles-path roles/
run: ## Run Ansible playbook
	ansible-playbook raspberry.yml -i inventory
prometheus: ## Run Ansible playbook for Prometheus roles
	ansible-playbook raspberry.yml -i inventory --tags prometheus
grafana: ## Run Ansible playbook for Grafana roles
	ansible-playbook raspberry.yml -i inventory --tags grafana
