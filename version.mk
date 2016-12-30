MAJOR_VERSION ?= 1
MINOR_VERSION ?= 0
PATCH_VERSION ?= 0

COMMIT_HASH = $$(git rev-parse HEAD | cut -c 1-7)
LABEL_VERSION ?= $(COMMIT_HASH)

MAJOR_STASH ?= .MAJOR_VERSION
MINOR_STASH ?= .MINOR_VERSION
PATCH_STASH ?= .PATCH_VERSION
HASH_STASH ?= .LABEL_VERSION

VERSION_FILE ?= VERSION
VERSION_NUMBER = $(MAJOR_VERSION).$(MINOR_VERSION).$(PATCH_VERSION)

.PHONY: build

version-reset:
	@if test -f $(MAJOR_STASH); then rm $(MAJOR_STASH); fi
	@if test -f $(MINOR_STASH); then rm $(MINOR_STASH); fi
	@if test -f $(PATCH_STASH); then rm $(PATCH_STASH); fi
	@if test -f $(HASH_STASH); then rm $(HASH_STASH); fi

clean: version-reset

$(MAJOR_STASH):
	@if ! test -f $(MAJOR_STASH); then echo $(MAJOR_VERSION) > $(MAJOR_STASH); fi

$(MINOR_STASH):
	@if ! test -f $(MINOR_STASH); then echo $(MINOR_VERSION) > $(MINOR_STASH); fi

$(PATCH_STASH):
	@if ! test -f $(PATCH_STASH); then echo $(PATCH_VERSION) > $(PATCH_STASH); fi

$(HASH_STASH):
	@if ! test -f $(HASH_STASH); then echo $(LABEL_VERSION) > $(HASH_STASH); fi

VERSION_NUMBER = $$(cat $(MAJOR_STASH)).$$(cat $(MINOR_STASH)).$$(cat $(PATCH_STASH))
FULL_VERSION = $(VERSION_NUMBER)-$(LABEL_VERSION)

full-version: $(PATCH_STASH) $(MINOR_STASH) $(MAJOR_STASH) $(HASH_STASH)
	@echo $(FULL_VERSION)

hash-version: $(HASH_STASH)
	@echo $(LABEL_VERSION)

version: $(PATCH_STASH) $(MINOR_STASH) $(MAJOR_STASH) $(HASH_STASH)
	@echo $(VERSION_NUMBER)


