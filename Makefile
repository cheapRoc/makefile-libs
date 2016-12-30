CONTAINER_NAME = devops/test

.PHONY: build

build: version
	@echo docker build -t $(CONTAINER_NAME):$(VERSION_NUMBER) .

include version.mk
include docker.mk
