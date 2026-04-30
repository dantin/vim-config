# make / make help — show usage (default goal)
# make archive   — full offline snapshot ($(TARBALL))
# make restore   — unpack so Vim works on the target host without network (:PlugInstall not required)
#
# Tarball name matches this directory (e.g. vim-config.tar.gz).
DISTRIBUTION := $(notdir $(abspath .))
TARBALL       ?= $(DISTRIBUTION).tar.gz
# After restore, RESTORE_DIR contains vimrc, vimrcs/, plugged/, autoload/plug.vim, .git/, …
RESTORE_DIR   ?=

.DEFAULT_GOAL := help
.PHONY: help archive restore

# --- help ------------------------------------------------------------------
help:
	@printf '%s\n' \
	  'Makefile — offline copy of this Vim config' \
	  '' \
	  'Targets:' \
	  '  make help       Show this message (default).' \
	  '  make archive    Write $(TARBALL) in the current directory (full tree: vimrcs/, plugged/,' \
	  '                   autoload/plug.vim, .git/, …; omits editor junk and the tarball itself).' \
	  '  make restore    Unpack $(TARBALL) into RESTORE_DIR (must be set).' \
	  '' \
	  'Variables:' \
	  '  TARBALL=path    Archive to read on restore (default: $(TARBALL)).' \
	  '  RESTORE_DIR=    Destination directory for restore (required).' \
	  '' \
	  'Examples:' \
	  '  make archive' \
	  '  make restore RESTORE_DIR=$$HOME/src/$(DISTRIBUTION)' \
	  '  make restore RESTORE_DIR=/opt/$(DISTRIBUTION) TARBALL=$$HOME/$(TARBALL)' \
	  '' \
	  'After restore: symlink ~/.vimrc -> RESTORE_DIR/vimrc and ~/.vim -> RESTORE_DIR,' \
	  'or cd RESTORE_DIR && ./install.sh' \
	  ''

# --- archive ---------------------------------------------------------------
# Complete copy of this tree: your vimrcs, vim-plug (plugged/ + autoload/plug.vim),
# CoC under plugged/, undodir, cache, files/*, .git/, etc. Nothing is stripped via
# exclude-from (previous versions omitted autoload/plug.vim and broke offline use).
# Only the tarball itself (if already present) and common editor/artifact names are omitted.
archive:
	@set -e; \
	b="$(DISTRIBUTION).tar.gz"; \
	printf 'Creating offline snapshot %s\n' "$$b"; \
	tar -czf "$$b" \
	  --exclude="$$b" \
	  --exclude='.DS_Store' \
	  --exclude='*.swp' \
	  --exclude='*.swo' \
	  --exclude='*.un~' \
	  --exclude='*~' \
	  --exclude='__pycache__' \
	  --exclude='*.pyc' \
	  --exclude='*.pyo' \
	  .

# --- restore ---------------------------------------------------------------
# Unpack $(TARBALL) into $(RESTORE_DIR). Layout matches the source repo; point
# ~/.vimrc at $(RESTORE_DIR)/vimrc and ~/.vim at $(RESTORE_DIR), or run ./install.sh there.
ifeq ($(strip $(RESTORE_DIR)),)
restore:
	$(error RESTORE_DIR is required. Example: make restore RESTORE_DIR=/path/to/vim-config)
else
restore:
	@test -f '$(TARBALL)' || { printf 'Missing %s (run make archive on a machine that has this repo)\n' '$(TARBALL)' >&2; exit 1; }
	mkdir -p '$(RESTORE_DIR)'
	tar -xzf '$(TARBALL)' -C '$(RESTORE_DIR)' -p
	@test -f '$(RESTORE_DIR)/vimrc' || { printf 'Missing %s/vimrc — archive may be corrupt\n' '$(RESTORE_DIR)' >&2; exit 1; }
	@test -f '$(RESTORE_DIR)/autoload/plug.vim' || { printf 'Missing %s/autoload/plug.vim — install vim-plug or re-archive\n' '$(RESTORE_DIR)' >&2; exit 1; }
	@test -d '$(RESTORE_DIR)/plugged' || { printf 'Missing %s/plugged — re-archive from a machine with :PlugInstall done\n' '$(RESTORE_DIR)' >&2; exit 1; }
	@for s in install.sh update.sh cleanup.sh; do \
	  f='$(RESTORE_DIR)'/"$$s"; \
	  if [ -f "$$f" ]; then chmod +x "$$f"; fi; \
	done
	@if git -C '$(RESTORE_DIR)' rev-parse --git-dir >/dev/null 2>&1; then \
	  printf 'Restored to %s — git %s; offline Vim ready (symlink ~/.vimrc / ~/.vim or run install.sh).\n' \
	    '$(RESTORE_DIR)' "$$(git -C '$(RESTORE_DIR)' rev-parse --short HEAD 2>/dev/null || echo '?')"; \
	else \
	  printf 'Restored to %s — no .git in archive; Vim layout OK for offline use.\n' '$(RESTORE_DIR)'; \
	fi
endif
