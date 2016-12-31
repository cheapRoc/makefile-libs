MAJOR_VERSION ?=
MINOR_VERSION ?=
PATCH_VERSION ?=

COMMIT_HASH = $$(git rev-parse HEAD | cut -c 1-7)
LABEL_VERSION ?= $(COMMIT_HASH)

MAJOR_STASH ?= .MAJOR_VERSION
MINOR_STASH ?= .MINOR_VERSION
PATCH_STASH ?= .PATCH_VERSION
HASH_STASH ?= .LABEL_VERSION

VERSION_FILE ?= VERSION
VERSION_NUMBER = $(MAJOR_VERSION).$(MINOR_VERSION).$(PATCH_VERSION)

clean: reset-version

reset-version:
	@if test -f $(MAJOR_STASH); then rm $(MAJOR_STASH); fi
	@if test -f $(MINOR_STASH); then rm $(MINOR_STASH); fi
	@if test -f $(PATCH_STASH); then rm $(PATCH_STASH); fi
	@if test -f $(HASH_STASH); then rm $(HASH_STASH); fi

debug-version:
	@echo
	@echo "\033[90mMAJOR_VERSION\033[0m: $(MAJOR_VERSION)"
	@echo "\033[90mMINOR_VERSION\033[0m: $(MINOR_VERSION)"
	@echo "\033[90mPATCH_VERSION\033[0m: $(PATCH_VERSION)"
	@echo "\033[90mCOMMIT_HASH\033[0m: $(COMMIT_HASH)"
	@echo "\033[90mMAJOR_STASH\033[0m: $(MAJOR_STASH)"
	@echo "\033[90mMINOR_STASH\033[0m: $(MINOR_STASH)"
	@echo "\033[90mPATCH_STASH\033[0m: $(PATCH_STASH)"
	@echo "\033[90mHASH_STASH\033[0m: $(HASH_STASH)"
	@echo

$(MAJOR_STASH):
	@if test -n "$(MAJOR_VERSION)"; then echo $(MAJOR_VERSION) > $(MAJOR_STASH); fi
	@if ! test -f $(MAJOR_STASH); then echo 1 > $(MAJOR_STASH); fi

$(MINOR_STASH):
	@if test -n "$(MINOR_VERSION)"; then echo $(MINOR_VERSION) > $(MINOR_STASH); fi
	@if ! test -f $(MINOR_STASH); then echo 0 > $(MINOR_STASH); fi

$(PATCH_STASH):
	@if test -n "$(PATCH_VERSION)"; then echo $(PATCH_VERSION) > $(PATCH_STASH); fi
	@if ! test -f $(PATCH_STASH); then echo 0 > $(PATCH_STASH); fi

$(HASH_STASH):
	@if test -n "$(LABEL_VERSION)"; then echo $(LABEL_VERSION) > $(HASH_STASH); fi
	@if ! test -f $(HASH_STASH); then echo $(COMMIT_HASH) > $(HASH_STASH); fi

VERSION_NUMBER = $$(cat $(MAJOR_STASH)).$$(cat $(MINOR_STASH)).$$(cat $(PATCH_STASH))
FULL_VERSION = $(VERSION_NUMBER)-$(LABEL_VERSION)

version: $(PATCH_STASH) $(MINOR_STASH) $(MAJOR_STASH) $(HASH_STASH)

full-version: version
	@echo $(FULL_VERSION)

short-version: version
	@echo $(VERSION_NUMBER)

hash-version: version
	@echo $(LABEL_VERSION)
