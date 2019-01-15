SOURCE_DIR   := $(shell pwd)
DISTRIBUTION := $(basename $(notdir $(SOURCE_DIR)))

DEFAULT: clean

.PHONY: clean
clean:
	@rm -f $(DISTRIBUTION).tar.gz
	@find files -type f -mindepth 2 ! -name '.gitkeep' -print -delete

.PHONY: archive
archive: clean
	@b=$(DISTRIBUTION).tar.gz; tar --exclude=$$b -czf $$b .
