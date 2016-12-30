CONTAINER_APP = test
CONTAINER_TEAM = devops

.PHONY: build

build: build-image version-image

publish: build publish-image

include version.mk
include docker.mk
