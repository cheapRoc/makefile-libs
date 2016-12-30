CONTAINER_NAME = devops/test

MAJOR_VERSION ?= 1
MINOR_VERSION ?= 0
PATCH_VERSION ?= 0
COMMIT_HASH ?= $$(git rev-parse HEAD | cut -c 1-7)
LABEL_VERSION ?= $(COMMIT_HASH)

MAJOR_STASH ?= .MAJOR_VERSION
MINOR_STASH ?= .MINOR_VERSION
PATCH_STASH ?= .PATCH_VERSION
HASH_STASH ?= .LABEL_VERSION

VERSION_FILE ?= VERSION
VERSION_NUMBER ?= $(MAJOR_VERSION).$(MINOR_VERSION).$(PATCH_VERSION)
FULL_VERSION = $(VERSION_NUMBER)-$(LABEL_VERSION)
COMMIT_VERSION = $(LABEL_VERSION)

.PHONY: build

reset:
	@if test -f $(MAJOR_STASH); then rm $(MAJOR_STASH); fi
	@if test -f $(MINOR_STASH); then rm $(MINOR_STASH); fi
	@if test -f $(PATCH_STASH); then rm $(PATCH_STASH); fi
	@if test -f $(HASH_STASH); then rm $(HASH_STASH); fi

$(MAJOR_STASH):
	@if ! test -f $(MAJOR_STASH); then echo $(MAJOR_VERSION) > $(MAJOR_STASH); fi
	@if test -ne $(MAJOR_VERSION) $$(cat $(MAJOR_STASH)); then MAJOR_VERSION = $$(cat $(MAJOR_STASH))

$(MINOR_STASH):
	@if ! test -f $(MINOR_STASH); then echo $(MINOR_VERSION) > $(MINOR_STASH); fi
	@if test -ne $(MINOR_VERSION) $$(cat $(MINOR_STASH)); then MINOR_VERSION = $$(cat $(MINOR_STASH))

$(PATCH_STASH):
	@if ! test -f $(PATCH_STASH); then echo $(PATCH_VERSION) > $(PATCH_STASH); fi
	@if test -ne $(PATCH_VERSION) $$(cat $(PATCH_STASH)); then PATCH_VERSION = $$(cat $(PATCH_STASH))

$(HASH_STASH):
	@if ! test -f $(HASH_STASH); then echo $(LABEL_VERSION) > $(HASH_STASH); fi
	@if test -ne $(LABEL_VERSION) $$(cat $(HASH_STASH)); then LABEL_VERSION = $$(cat $(HASH_STASH))

full-version: version
	@echo $(VERSION_NUMBER)-$(LABEL_VERSION)

version: $(PATCH_STASH) $(MINOR_STASH) $(MAJOR_STASH) $(HASH_STASH)
#	@echo $(MAJOR_VERSION).$(MINOR_VERSION).$$(cat $(PATCH_STASH))-$(LABEL_VERSION)
	VERSION_NUMBER = $(MAJOR_VERSION).$(MINOR_VERSION).$$(cat $(PATCH_STASH))-$(LABEL_VERSION)
	@echo $(VERSION_NUMBER)
	@echo $(FULL_VERSION)


