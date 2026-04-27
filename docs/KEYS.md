# Key maps

`mapleader` is the **space bar** (see `vimrcs/keymaps.vim`).

This file lists custom bindings. **Git** (vim-fugitive + vim-gitgutter) uses LazyVim-style **`<leader>g…`** and **`]h` / `[h`**, defined in `vimrcs/git.vim`. For ex commands not listed here, see each plugin’s help.

---

## General (built-in + this repo)

| Key | Mode | Action |
|-----|------|--------|
| `Space` then key | Normal | `mapleader` is a literal Space, so e.g. **Space, e** opens NERDTree. A **single** Space in Normal mode is Vim’s default (scroll forward); it is *not* remapped, so the leader can work. |
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
| `<leader>e` | Toggle NERDTree (`:NERDTreeToggle`) |
| `<leader>E` | Reveal current file in the tree (`:NERDTreeFind`) |

When the **NERDTree** window is active, the plugin’s own buffer maps apply. Press `?` inside the tree for the built-in quick reference (open, split, etc.).

**`E492: Not an editor command: NERDTreeToggle` (or `NERDTreeFind`):** those ex commands are created only when the NERDTree plugin is loaded. Typical causes: plugins were installed with `vim-plug` into a different `plugged/` than this config uses (common with **Neovim**, which uses `~/.local/share/nvim/plugged` by default, not `~/.vim/plugged`), or `plugged/nerdtree` is missing. From the same editor you use daily, run **`:PlugInstall`**, or **`:PlugStatus`** to see whether `nerdtree` is `OK`. The bundle path is chosen in `vimrcs/plugs.vim` (and `g:vimrc_config_dir` in the top `vimrc`).

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

## Git: vim-fugitive & vim-gitgutter (LazyVim-aligned)

Defined in `vimrcs/git.vim`. LazyVim uses [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) and [snacks.nvim](https://github.com/folke/snacks.nvim) pickers; this Vim stack maps the **same leader patterns** to **Fugitive** and **gitgutter** where possible. Default gitgutter keymaps are off (`g:gitgutter_map_keys = 0` in `vimrcs/plugs.vim`).

In the Fugitive **index / status** buffer, buffer-local keys still apply; press `g?` there for the built-in list.

### Status, log, diff, blame, browse

| Key | Fugitive / effect |
|-----|------------------|
| `<leader>gs` | `:Git` — main status / Git UI |
| `<leader>gS` | `:Git! stash` — stash (opens stash UI) |
| `<leader>gb` | `:Gblame` — blame in split |
| `<leader>ghb` | Same as `<leader>gb` (Gitsigns’ blame-line slot) |
| `<leader>gd` | `:Gvdiff` — working tree vs index |
| `<leader>gD` | `:Gvdiffsplit! @{u}` — diff vs upstream |
| `<leader>gl` | `:Glog` — commit browser (repo) |
| `<leader>gL` | `!git log` — shell `git log` in pager (LazyVim uses a picker) |
| `<leader>gf` | `:0Glog` — history for the current file |

`GBrowse` / yank-URL: add [vim-rhubarb](https://github.com/tpope/vim-rhubarb) and optional maps in `git.vim` (see commented example).

If **`lazygit`** is on `PATH`, `<leader>gg` runs `!lazygit` in the current directory, and **`<leader>gG`** runs `!lazygit` after `lcd` to the buffer’s directory (LazyVim’s “Git UI (cwd)”-style; local `cwd` stays in that path until you `:cd` / `:tcd` / `:lcd` elsewhere).

### Hunks (Gitsigns `]h` / `ghs` + … on LazyVim → gitgutter + Git)

| Key | Action |
|-----|--------|
| `[h` / `]h` | Previous / next hunk (`<Plug>`) |
| `<leader>ghp` | Preview hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset / undo hunk in the buffer |
| `<leader>ghu` | `Git! reset HEAD -- %` — unstage whole file (Gitsigns “undo stage”); needs Git that supports the plumbing Fugitive uses for `git reset` |
| `<leader>ghS` | `Git! add %` — stage whole file |
| `<leader>ghR` | `Git! restore %` — discard file changes to `HEAD` (Git ≥2.23; or use `:Gread! HEAD` manually on older Git) |
| `<leader>ghd` | `:GitGutterDiffOrig` — diff style like `:DiffOrig` (git) |
| `<leader>ghD` | `:Gvdiffsplit! HEAD^` — diff vs first parent of `HEAD` (approx. “Diff This `~`” in Gitsigns) |
| `ih` / `ah` | operator / visual **inner** and **a** hunk (maps to gitgutter’s `ic` / `ac` text objects) |

Fugitive status buffer: **`-`**, **`s`**, **`.`**, **`cc`**, **etc.** still work; see **`:h fugitive`** and `g?` in that window.

### Git UI inside NERDTree / fzf

`<leader>sg` (fzf `Rg`) is **find in files**, not a Git subcommand. **`<leader>g*`** is reserved for Git. No Git maps use `<leader>ff` or `<leader>sg`.

---

## Other plugins in this config

| Plugin | Note |
|--------|------|
| **vim-go** | No custom leader maps. LSP from **coc**; `g:go_gopls_enabled` is 0. `:h go-commands` |
| **vim-commentary** | `gc`, `gcc` — see `:h commentary` |
| **vim-surround** | `ys`, `ds`, `cs` — see `:h surround` |
| **auto-pairs** | Pairs; `<CR>` with coc; `g:AutoPairsMapCR` in `vimrcs/plugs.vim` |
| **vim-airline** | Status line. See `:h airline` |
| **vim-polyglot** | Syntax/indent; no key maps from this config |

To see what a key is bound to: `:verbose map <key>`.
