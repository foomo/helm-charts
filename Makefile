-include .makerc
.DEFAULT_GOAL:=help

# --- Config -----------------------------------------------------------------

# Newline hack for error output
define br


endef

# --- Targets -----------------------------------------------------------------

# This allows us to accept extra arguments
%: .mise .lefthook
	@:

.PHONY: .mise
# Install dependencies
.mise:
ifeq (, $(shell command -v mise))
	$(error $(br)$(br)Please ensure you have 'mise' installed and activated!$(br)$(br)  $$ brew update$(br)  $$ brew install mise$(br)$(br)See the documentation: https://mise.jdx.dev/getting-started.html)
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
	@helm-schema -ran -c charts/beam
	@helm-schema -ran -c charts/backups
	@helm-schema -ran -c charts/blank -k additionalProperties
	@helm-schema -ran -c charts/namespace
	@helm-schema -ran -c charts/sesamy-gtm
	@helm-schema -ran -c charts/sesamy-umami
	@helm-schema -ran -c charts/gateway-crds
	@helm-schema -ran -c charts/contentserver -k additionalProperties
	@helm-schema -ran -c charts/squadron-server
	@helm-schema -ran -c charts/squadron-cronjob
	@helm-schema -ran -c charts/squadron-keel-server
	@helm-schema -ran -c charts/squadron-keel-cronjob
	@helm-schema -ran -c charts/squadron-nextjs-server
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
	@helm plugin install --verify=false https://github.com/KnechtionsCoding/helm-schema-gen.git

.PHONY: help
# https://patorjk.com/software/taag/#p=display&f=Tmplr&t=helm+charts&x=none&v=4&h=4&w=80&we=false
## Show help text
help: g=\033[0;32m
help: b=\033[0;34m
help: w=\033[0;90m
help: e=\033[0m
help:
	@echo "$(g)"
	@echo "┓   ┓      ┓"
	@echo "┣┓┏┓┃┏┳┓  ┏┣┓┏┓┏┓╋┏"
	@echo "┛┗┗ ┗┛┗┗  ┗┛┗┗┻┛ ┗┛"
	@echo "with ❤ foomo by bestbytes"
	@echo "$(e)"
	@echo "$(b)Usage:$(e)\n  make [task]"
	@awk '{ \
		if($$0 ~ /^### /){ \
			if(help) printf "  %-21s $(w)%s$(e)\n\n", cmd, help; help=""; \
			printf "$(b)\n%s:$(e)\n", substr($$0,5); \
		} else if($$0 ~ /^[a-zA-Z0-9._-]+:/){ \
			cmd = substr($$0, 1, index($$0, ":")-1); \
			if(help) printf "  %-21s $(w)%s$(e)\n", cmd, help; help=""; \
		} else if($$0 ~ /^##/){ \
			help = help ? help "\n                        " substr($$0,3) : substr($$0,3); \
		} else if(help){ \
			print "\n                        $(w)" help "$(e)\n"; help=""; \
		} \
	}' $(MAKEFILE_LIST)
	@echo ""

