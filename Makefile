SOURCE_DIR := $(shell pwd)

DEFAULT: clean

.PHONY: clean
clean:
	@rm -f vim-config.tar.gz
	@find files -type f -mindepth 2 ! -name '.gitkeep' -print -delete

.PHONY: archive
archive: clean
	@b=vim-config.tar.gz; tar --exclude=$$b -czf $$b .
