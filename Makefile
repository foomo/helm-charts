-include .makerc
.DEFAULT_GOAL:=help

# --- Targets -----------------------------------------------------------------

.PHONY: check
## Lint, Schema & docs
check: lint schema docs
	@echo "done"

.PHONY: lint
## Lint Helm charts
## https://github.com/helm/chart-testing
lint:
	@for dir in ./charts/* ; do \
		helm lint $${dir} ;\
	done

.PHONY: docs
## Generate README
## https://github.com/norwoodj/helm-docs
docs:
	@helm-docs . --template-files ./README.md.gotmpl

.PHONY: schema
## Generate values JSON schema
## https://github.com/knechtionscoding/helm-schema-gen
schema: PWD=$(pwd)
schema:
	@for dir in ./charts/* ; do \
		helm schema-gen $${dir}/values.yaml > $${dir}/values.schema.json ;\
	done


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
