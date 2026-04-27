# Environment & dependencies

This config is built from the top-level `vimrc` and `vimrcs/*.vim`. Everything below is derived from what those files load, call, or assume on `PATH`.

## Runtime

| Requirement | Why |
|-------------|-----|
| **Vim 8+** or **Neovim** | `vimrc` / modules (e.g. `set signcolumn=auto`, `filetype plugin indent on`, `plug#begin`, coc, fzf). |
| `+job` / async (recommended) | coc.nvim, plugin post-install hooks, and a smooth experience. |
| `+clipboard` (recommended) | `set clipboard=unnamedplus` in `vimrcs/options.vim` needs a build with clipboard support (on Linux you often need `xclip` or `xsel` / Wayland equivalent). |

## Required for this setup

| Tool | Role in this repo |
|------|---------------------|
| [**vim-plug**](https://github.com/junegunn/vim-plug) | Plugin manager; `call plug#begin` in `vimrcs/plugs.vim` expects `autoload/plug.vim`. |
| **curl** | Used by `bootstrap.sh` to install `plug.vim` (and any other downloaded assets the script fetches). |
| **Node.js** | **coc.nvim** runs on Node. Install a current LTS. |
| **npm** (usually with Node) | coc uses it to install language servers and extension packages. |
| **Git** | Used by **vim-fugitive**, **vim-gitgutter**, NERDTree in git repos, **vim-go** / tooling, and `fzf.vim` / `g:rg_derive_root` behavior. A normal `git` on `PATH` is required for those features. |

### Install vim-plug

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

If the config lives in a clone and `~/.vim` is symlinked to that directory (as in `bootstrap.sh`), install to **`$REPO/autoload/plug.vim`** instead of `~/.vim/...` so the path matches.

### First-time inside Vim

After `vim-plug` and this config are in place:

1. **`:PlugInstall`** — install all `Plug` entries in `vimrcs/plugs.vim` (coc, fzf, NERDTree, gruvbox, etc.).
2. **`:CocUpdate`** (or **`:CocInstall`**) — install coc extensions (see [coc](#cocnvim--language-tooling) below).
3. Optional: **`:GoUpdateBinaries`** if you use **vim-go** (installs/fetches Go tools; needs **Go** on `PATH`).

## coc.nvim & language tooling

`g:coc_global_extensions` in `vimrcs/coc.vim` pins these coc extensions; each has its own expectations:

| Extension | Typical system / notes |
|-----------|-------------------------|
| **coc-pyright** | [Pyright](https://github.com/microsoft/pyright) (pulled in via coc/Node). A **Python** interpreter is only needed to *run* or *lint* your project, not to install the extension. |
| **coc-clangd** | [**clangd**](https://clangd.llvm.org/) on `PATH` (e.g. LLVM), or let coc download it when prompted. |
| **coc-go** | [**gopls**](https://github.com/golang/tools/tree/master/gopls) (Go language server). Install **Go** and ensure `gopls` is available, or use coc’s install flow. `vimrcs/plugs.vim` sets `g:go_gopls_enabled = 0` so **gopls** is not also started by vim-go. |
| **coc-json** | No extra system deps beyond Node. |
| **coc-snippets** | Snippet engine; snippet sources are configured separately if you add them. |

## fzf & search

| Tool | Role |
|------|------|
| [**fzf**](https://github.com/junegunn/fzf) | Bundled as a **vim-plug** plugin; `vimrcs/plugs.vim` uses `'do': 'call fzf#install()'` to build the **fzf** binary. You can also install `fzf` with your package manager and ensure it is on `PATH`. |
| [**ripgrep**](https://github.com/BurntSushi/ripgrep) (`rg`) | **Optional but recommended.** `vimrcs/fzf.vim` only sets `FZF_DEFAULT_COMMAND` and `grepprg` when `executable('rg')` is true. Without `rg`, fzf falls back to other file listing; `:Rg` in **fzf.vim** still expects `rg` for the intended behavior. |

## Git integration (Fugitive, gitgutter, maps)

| Tool | Role |
|------|------|
| **Git** | Required for **vim-fugitive**, **vim-gitgutter**, and the commands in `vimrcs/git.vim` (`:Git`, `!git log`, `Git! restore`, etc.). |
| **Git ≥ 2.23** (recommended) | `vimrcs/git.vim` uses `Git! restore %` for **`<leader>ghR`**. On older Git, use equivalent commands manually or adjust the map. |
| [**lazygit**](https://github.com/jesseduffield/lazygit) | **Optional.** `<leader>gg` and `<leader>gG` are only mapped when `executable('lazygit')` is true (`vimrcs/git.vim`). |

Optional **GitHub** integration: [vim-rhubarb](https://github.com/tpope/vim-rhubarb) for `:GBrowse` (not in the default `Plug` list; see comments in `vimrcs/git.vim`).

## Go (vim-go)

| Tool | Role |
|------|------|
| **Go** (`go` on `PATH`) | **vim-go** is loaded with `{ 'do': ':GoUpdateBinaries' }`, which downloads tools (e.g. **gopls** for vim-go, **golangci-lint**, etc., depending on vim-go version and settings). For day-to-day Go editing, install a recent **Go** SDK. |

## Bootstrap script (`./bootstrap.sh`)

| Dependency | Use |
|------------|-----|
| **bash** | Script interpreter. |
| **curl** | Download **vim-plug** (and any other assets the script fetches). |
| **ln** | Create symlinks for `~/.vimrc` and `~/.vim` → config directory. |
| **vim** | Non-interactive `vim +PlugInstall +qall` to install plugins. |

## Summary checklist

- [ ] **Vim** or **Neovim** (reasonably new).
- [ ] **vim-plug** in `autoload/plug.vim` (see above).
- [ ] **Node.js** + **npm** (for **coc.nvim**).
- [ ] **Git** (Fugitive, gitgutter, and Go/plugin workflows).
- [ ] Run **`:PlugInstall`**, then **`:CocUpdate`** (or install coc extensions you need).
- [ ] **Optional:** **ripgrep** (`rg`), **fzf** on `PATH` if you do not rely on the plug-in’s `fzf#install()`, **lazygit**, **Go** (for vim-go / gopls), **clangd** (for C/C++ via coc-clangd).

For key bindings, see [KEYS.md](KEYS.md). For the repository layout, see [README.md](../README.md).
