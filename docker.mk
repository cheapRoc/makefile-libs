CONTAINER_APP ?= nginx-test
CONTAINER_TEAM ?= devops
CONTAINER_IMAGE = $(CONTAINER_TEAM)/$(CONTAINER_APP)
CONTAINER_TAG ?= $(VERSION_NUMBER)
IMAGE_TAG = $(CONTAINER_IMAGE):$(CONTAINER_TAG)

REGISTRY_HOST ?= docker-dev.rxcorp.com
REGISTRY_TAG = $(REGISTRY_HOST)/$(IMAGE_TAG)

debug-image: version
	@echo
	@echo "\033[90mCONTAINER_APP\033[0m: $(CONTAINER_APP)"
	@echo "\033[90mCONTAINER_TEAM\033[0m: $(CONTAINER_TEAM)"
	@echo "\033[90mCONTAINER_IMAGE\033[0m: $(CONTAINER_IMAGE)"
	@echo "\033[90mIMAGE_TAG\033[0m: $(IMAGE_TAG)"
	@echo "\033[90mREGISTRY_HOST\033[0m: $(REGISTRY_HOST)"
	@echo "\033[90mREGISTRY_TAG\033[0m: $(REGISTRY_TAG)"
	@echo

build-image:
	docker build -t $(CONTAINER_IMAGE) .

version-image: version build-image
	docker tag $(CONTAINER_IMAGE) $(IMAGE_TAG)

register-image: version-image
	docker tag $(IMAGE_TAG) $(REGISTRY_TAG)

publish-image: register-image
	docker push $(REGISTRY_TAG)

destroy-all-containers:
	@echo docker rmi $(IMAGE_TAG)
	@echo docker rmi $(CONTAINER_TAG)
	@echo docker rmi $(REGISTRY_TAG)
	@echo docker rmi $(CONTAINER_IMAGE)

peak-confusion:
	@echo What is a container?
	@echo What is my container IP?
	@echo Why do I need a random port number?
	@echo What is a port array?
	@echo Which Mesos agent is this running on?
	@echo What random port number is running on which random agent?
	@echo What is Marathon LB and what is it doing to HAProxy?
