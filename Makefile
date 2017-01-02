CONTAINER_APP = test
CONTAINER_TEAM = devops

.PHONY: build

build: build-image version-image

test: bats-test

publish: build publish-image

release: build test publish release-version

include version.mk
include docker.mk
include bats.mk
