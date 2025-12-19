-include .makerc
.DEFAULT_GOAL:=help

# --- Config -----------------------------------------------------------------

# Newline hack for error output
define br


endef

# --- Targets -----------------------------------------------------------------

# This allows us to accept extra arguments
%: .mise .husky
	@:

.PHONY: .mise
# Install dependencies
.mise: msg := $(br)$(br)Please ensure you have 'mise' installed and activated!$(br)$(br)$$ brew update$(br)$$ brew install mise$(br)$(br)See the documentation: https://mise.jdx.dev/getting-started.html$(br)$(br)
.mise:
ifeq (, $(shell command -v mise))
	$(error ${msg})
endif
	@mise install

.PHONY: .husky
# Configure git hooks for husky
.husky:
	@git config core.hooksPath .husky

### Tasks

.PHONY: check
## Lint, Schema & docs
check: lint docs

.PHONY: lint
## Lint Helm charts (https://github.com/helm/chart-testing)
lint: schema
	@echo "--- lint ------------------------------------------"
	@set -e; for dir in ./charts/* ; do \
		helm lint $${dir} ;\
	done

.PHONY: docs
## Generate README (https://github.com/norwoodj/helm-docs)
docs:
	@echo "--- docs ------------------------------------------"
	@set -e; for dir in ./charts/* ; do \
		docker run --rm --volume "$$(pwd)/$${dir}:/helm-docs/$${dir}" jnorwood/helm-docs:v1.14.2 --template-files "$${dir}/README.md.gotmpl"  ;\
	done

# (https://github.com/knechtionscoding/helm-schema-gen)
.PHONY: schema
## Generate values JSON schema
schema: PWD=$(pwd)
schema:
	@echo "--- schema ---------------------------------------"
	@helm-schema -n -c charts/beam
	@helm-schema -n -c charts/backups
	@helm-schema -n -c charts/blank -k additionalProperties
	@helm-schema -n -c charts/namespace
	@helm-schema -n -c charts/sesamy-gtm
	@helm-schema -n -c charts/sesamy-umami
	@helm-schema -n -c charts/gateway-crds
	@helm-schema -n -c charts/contentserver -k additionalProperties
	@helm-schema -n -c charts/squadron-server
	@helm-schema -n -c charts/squadron-cronjob
	@helm-schema -n -c charts/squadron-keel-server
	@helm-schema -n -c charts/squadron-keel-cronjob
	@helm-schema -n -c charts/squadron-nextjs-server
	@helm schema-gen charts/csp-reporter/values.yaml > charts/csp-reporter/values.schema.json

### K3d

export KUBECONFIG=$(shell pwd)/tmp/kubeconfig.yaml

k3d.%: NAME=foomo-helm-charts
k3d.%: PORT=8543
k3d.%: VERSION=v1.30.2-k3s2

.PHONY: k3d.up
## Startup local cluster
k3d.up:
	@k3d cluster create ${NAME} \
		--image=rancher/k3s:${VERSION} \
		--registry-create ${NAME}-registry:8542
		--k3s-arg "--disable=traefik@server:0" \
		--port "${PORT}:443@loadbalancer" \
		--agents 1

.PHONY: k3d.down
## Shutdown local cluster
k3d.down:
	@k3d cluster delete ${NAME}

### Utils

.PHONY: deps
## Install helm plugins
deps:
	@helm plugin install https://github.com/KnechtionsCoding/helm-schema-gen.git

.PHONY: help
## Show help text
help:
	@echo "Squadron Helm Charts\n"
	@echo "Usage:\n  make [task]"
	@awk '{ \
		if($$0 ~ /^### /){ \
			if(help) printf "%-23s %s\n\n", cmd, help; help=""; \
			printf "\n%s:\n", substr($$0,5); \
		} else if($$0 ~ /^[a-zA-Z0-9._-]+:/){ \
			cmd = substr($$0, 1, index($$0, ":")-1); \
			if(help) printf "  %-23s %s\n", cmd, help; help=""; \
		} else if($$0 ~ /^##/){ \
			help = help ? help "\n                        " substr($$0,3) : substr($$0,3); \
		} else if(help){ \
			print "\n                        " help "\n"; help=""; \
		} \
	}' $(MAKEFILE_LIST)
