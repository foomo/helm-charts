-include .makerc
.DEFAULT_GOAL:=help

# --- Targets -----------------------------------------------------------------

## === Tasks ===

.PHONY: check
## Lint, Schema & docs
check: lint docs

.PHONY: lint
## Lint Helm charts
## https://github.com/helm/chart-testing
lint: schema
	@echo "--- lint ------------------------------------------"
	@set -e; for dir in ./charts/* ; do \
		helm lint $${dir} ;\
	done

.PHONY: docs
## Generate README
## https://github.com/norwoodj/helm-docs
docs:
	@echo "--- docs ------------------------------------------"
	@set -e; for dir in ./charts/* ; do \
		docker run --rm --volume "$$(pwd)/$${dir}:/helm-docs/$${dir}" jnorwood/helm-docs:v1.14.2 --template-files "$${dir}/README.md.gotmpl"  ;\
	done

.PHONY: schema
## Generate values JSON schema
## https://github.com/knechtionscoding/helm-schema-gen
schema: PWD=$(pwd)
schema:
	@echo "--- schema ---------------------------------------"
	helm-schema -n -c charts/beam
	helm-schema -n -c charts/namespace
	helm-schema -n -c charts/sesamy-gtm
	helm-schema -n -c charts/squadron-keel-server
	helm-schema -n -c charts/squadron-keel-cronjob
	helm-schema -n -c charts/squadron-nextjs-server
	helm schema-gen charts/contentserver/values.yaml > charts/contentserver/values.schema.json
	helm schema-gen charts/csp-reporter/values.yaml > charts/csp-reporter/values.schema.json
	helm schema-gen charts/gateway-crds/values.yaml > charts/gateway-crds/values.schema.json
	helm schema-gen charts/sesamy-umami/values.yaml > charts/sesamy-umami/values.schema.json
	#@set -e; for dir in ./charts/* ; do \
	#	helm-schema -n -c $${dir} ;\
	#done

## === K3d ===

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

## === Utils ===

.PHONY: help
## Show help text
help:
	@awk '{ \
		if ($$0 ~ /^.PHONY: [a-zA-Z\-\_0-9]+$$/) { \
			helpCommand = substr($$0, index($$0, ":") + 2); \
			if (helpMessage) { \
				printf "\033[36m%-23s\033[0m %s\n", \
					helpCommand, helpMessage; \
				helpMessage = ""; \
			} \
		} else if ($$0 ~ /^[a-zA-Z\-\_0-9.]+:/) { \
			helpCommand = substr($$0, 0, index($$0, ":")); \
			if (helpMessage) { \
				printf "\033[36m%-23s\033[0m %s\n", \
					helpCommand, helpMessage"\n"; \
				helpMessage = ""; \
			} \
		} else if ($$0 ~ /^##/) { \
			if (helpMessage) { \
				helpMessage = helpMessage"\n                        "substr($$0, 3); \
			} else { \
				helpMessage = substr($$0, 3); \
			} \
		} else { \
			if (helpMessage) { \
				print "\n                        "helpMessage"\n" \
			} \
			helpMessage = ""; \
		} \
	}' \
	$(MAKEFILE_LIST)
