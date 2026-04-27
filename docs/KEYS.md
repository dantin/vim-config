# Key maps

`mapleader` is the **space bar** (see `vimrcs/keymaps.vim`).

This file lists custom bindings from this config. Other plugins (e.g. vim-fugitive, gitgutter) use their **default** key maps unless you add your own; see each plugin’s help.

---

## General (built-in + this repo)

| Key | Mode | Action |
|-----|------|--------|
| `Space` | Normal | Leader (not bound alone) |
| `Esc` | Normal | Clear search highlight (`:nohlsearch`) |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Normal | Move between split windows (`<C-w>h` … `l`) |
| `<S-h>` | Normal | Previous buffer (`:bprevious`); on many layouts this is the same physical key as `H` and overrides the default “top of window” `H` motion |
| `<S-l>` | Normal | Next buffer (`:bnext`); may override the default `L` (“bottom of window”) motion |
| `<leader>bd` | Normal | Delete current buffer |
| `<leader>w` | Normal | Write buffer (`:w`) |
| `<leader>q` | Normal | Quit window (`:q`) |

---

## NERDTree (this config)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle NERDTree |
| `<leader>E` | Reveal current file in the tree (`NERDTreeFind`) |

When the **NERDTree** window is active, the plugin’s own buffer maps apply. Press `?` inside the tree for the built-in quick reference (open, split, etc.).

---

## coc.nvim (LSP & completion)

Defined in `vimrcs/coc.vim`. Requires coc to be running; run `:CocInfo` or `:CocList extensions` to inspect.

### Insert mode (completion)

| Key | Action |
|-----|--------|
| `Tab` | If pop-up menu is open: next item. Else if at “start” of line or after whitespace: real `Tab`. Else: refresh (`coc#refresh()`). |
| `Shift+Tab` | If menu open: previous item. Else: `Ctrl-h` (backspace-like). |
| `Enter` | If menu open: confirm. Else: normal new line + `coc#on_enter()`. |

### Normal mode (navigation & refactor)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `gy` | Type definition |
| `gi` | Go to implementation |
| `K` | Hover documentation; in `filetype` **vim** or **help** runs `:help` on `<cword>`; otherwise `doHover` or default `K` |
| `<leader>cr` | Rename symbol |
| `<leader>ca` | Code action (normal: at cursor; visual: selected range) |
| `<leader>cf` | Format buffer / range |

### Diagnostics

| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>cd` | Show diagnostic info for the current line |

### Commands you may use often

- `:CocUpdate` — update extensions.
- `:CocRestart` — restart the service.
- See `:h coc` for the full list.

### Bundled extension IDs (for reference)

`coc-pyright`, `coc-clangd`, `coc-go`, `coc-json`, `coc-snippets` (see `g:coc_global_extensions` in `vimrcs/coc.vim`).

---

## fzf & fzf.vim

`vimrcs/fzf.vim` sets ripgrep as the file source when `rg` is available, and `grepprg` for `:grep` / `vimgrep`-style use.

| Key | Command | Purpose |
|-----|---------|---------|
| `<leader>ff` | `:Files` | Fuzzy file picker |
| `<leader>sg` | `:Rg` | Ripgrep in project (content search) |
| `<leader>fb` | `:Buffers` | Open buffer |
| `<leader>fr` | `:History` | Recent file history |
| `<leader>sc` | `History:` | Ex-command history |
| `<leader>/` | `:BLines` | Lines in the current buffer |

Default **fzf** in-window keys (e.g. `Ctrl-t` new tab, `Ctrl-x` split) follow **fzf.vim**; see `:h fzf-vim` and fzf’s own docs.

---

## Other plugins in this config (no extra leader maps here)

| Plugin | Note |
|--------|------|
| **vim-go** | No custom leader maps in this repo. LSP-style jumps use **coc** above. `g:go_gopls_enabled` is 0. Use ex commands (e.g. `:GoTest`, `:GoBuild`) as needed; `:h go-commands` |
| **vim-commentary** | `gc` (operator), `gcc` (line) — see `:h commentary` |
| **vim-surround** | `ys`, `ds`, `cs`, etc. — see `:h surround` |
| **auto-pairs** | Inserts matching pairs; `<CR>` is coordinated with coc (`g:AutoPairsMapCR = 0` in `vimrcs/plugs.vim`) |
| **vim-fugitive** | `:G`, `:Git`, `:Gblame` — see `:h fugitive` |
| **vim-airline** | Status line; tabline is off. See `:h airline` |
| **vim-polyglot** | File-type syntax/indent; no key maps from this config |

To print what a key runs in your session, use `:verbose map <key>` or `:nmap` / `:imap` as needed.
