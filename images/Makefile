GOLANGCI_LINT_VER ?= 1.39.0
STOLON_REVISION ?= v0.16.0
POSTGRES_VERSION ?= 12
GOLANG_VERSION ?= 1.16.3

.PHONY: all
all: images

UNINSTALL_TAG := stolon-uninstall:$(VERSION)
HOOK_TAG := stolon-hook:$(VERSION)
STOLON_TAG := stolon:$(VERSION)
TELEGRAF_TAG := stolon-telegraf:$(VERSION)
PGBOUNCER_TAG := stolon-pgbouncer:$(VERSION)
ETCD_TAG := stolon-etcd:$(VERSION)
COMMON_TAG := stolon-common:$(VERSION)

.PHONY: images
images:	uninstall \
		stolon \
		telegraf \
		hook \
		pgbouncer \
		etcd \
		common
	docker tag $(UNINSTALL_TAG) stolon-uninstall:latest
	docker tag $(STOLON_TAG) stolon:latest
	docker tag $(HOOK_TAG) stolon-hook:latest
	docker tag $(TELEGRAF_TAG) stolon-telegraf:latest
	docker tag $(PGBOUNCER_TAG) stolon-pgbouncer:latest
	docker tag $(ETCD_TAG) stolon-etcd:latest
	docker tag $(COMMON_TAG) stolon-common:latest

IMAGES_FOR_BUILD := uninstall telegraf pgbouncer etcd common
TAG_VARIABLE_NAME = $(shell echo '$@' | tr '[:lower:]' '[:upper:]')_TAG
.PHONY: $(IMAGES_FOR_BUILD)
$(IMAGES_FOR_BUILD):
	docker build --pull -t $($(TAG_VARIABLE_NAME)) $@

.PHONY: hook
hook:
	$(eval CHANGESET = $(shell echo '$(VERSION)' | sed -e 's/[\.]//g'))
	if [ -z "$(CHANGESET)" ]; then \
		echo "CHANGESET is not set"; exit 1; \
	fi;
	docker build --pull --build-arg CHANGESET=stolon-$(CHANGESET) -t $(HOOK_TAG) $(PWD)/hook

.PHONY: stolon
stolon:
	docker build --pull --build-arg STOLON_REVISION=$(STOLON_REVISION) --build-arg PGVERSION=$(POSTGRES_VERSION) \
        --build-arg GOLANG_VERSION=$(GOLANG_VERSION) -t $(STOLON_TAG) $(PWD)/stolon
