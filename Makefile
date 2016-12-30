CONTAINER_NAME = devops/test

.PHONY: build

build: version
	@echo docker build -t $(CONTAINER_NAME):$(MAJOR_VERSION).$(MINOR_VERSION).$$(cat $(PATCH_STASH))-$(LABEL_VERSION)

include version.mk
