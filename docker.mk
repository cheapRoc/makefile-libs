CONTAINER_APP ?= nginx-test
CONTAINER_TEAM ?= devops
CONTAINER_IMAGE = $(CONTAINER_TEAM)/$(CONTAINER_APP)
CONTAINER_TAG ?= $(VERSION_NUMBER)
IMAGE_TAG = $(CONTAINER_IMAGE):$(CONTAINER_TAG)

REGISTRY_HOST = docker-dev.rxcorp.com
REGISTRY_TAG = $(REGISTRY_HOST)/$(IMAGE_TAG)

build-image:
	@echo docker build -t $(CONTAINER_IMAGE) .

version-image: version build-image
	@echo docker tag $(CONTAINER_IMAGE) $(IMAGE_TAG)

register-image: version-image
	@echo docker tag $(IMAGE_TAG) $(REGISTRY_TAG)

publish-image:
	@echo docker push $(REGISTRY_TAG)

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
