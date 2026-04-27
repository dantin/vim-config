# Vim Configuration

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

A modular Vim setup: [vim-plug](https://github.com/junegunn/vim-plug) for plugins, [coc.nvim](https://github.com/neoclide/coc.nvim) for LSP and completion, [fzf](https://github.com/junegunn/fzf) for fuzzy search, and a file-tree / Git helpers around a **gruvbox** theme. Configuration is split under `vimrcs/` and loaded from the top-level `vimrc`.

## Table of Contents

- [What’s included](#whats-included)
- [Layout](#layout)
- [Requirements](#requirements)
- [Install](#install)
- [Documentation](#documentation)
- [Background](#background)
- [Related efforts](#related-efforts)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## What’s included

| Area | Stack |
|------|--------|
| LSP & completion | coc.nvim (Pyright, clangd, gopls via coc-go, JSON, snippets) |
| Syntax / editing | vim-polyglot, auto-pairs, vim-commentary, vim-surround |
| Go | [vim-go](https://github.com/fatih/vim-go) (LSP and `:GoDef`-style features come from coc; vim-go’s gopls integration is off to avoid a second gopls) |
| UI | gruvbox, vim-airline, NERDTree |
| Fuzzy find | fzf + fzf.vim (ripgrep when `rg` is on `PATH`) |
| Git | vim-fugitive, vim-gitgutter |

Undo history is kept in a local `undodir/` next to the config (created automatically).

## Layout

| Path | Role |
|------|------|
| `vimrc` | Resolves config path (works when `~/.vimrc` is a symlink), sets `undodir` / `undofile`, sources `vimrcs/*.vim` |
| `vimrcs/options.vim` | Core editor options, Go `FileType` (tabs) |
| `vimrcs/plugs.vim` | `vim-plug` (`plug#begin` picks colocated, Nvim, or `~/.vim` `plugged/`), plugin toggles |
| `vimrcs/appearance.vim` | `background` + gruvbox |
| `vimrcs/keymaps.vim` | Leader, windows, buffers, NERDTree open/find |
| `vimrcs/coc.vim` | coc LSP, completion, diagnostics |
| `vimrcs/fzf.vim` | `rg` / fzf default command, pickers |
| `vimrcs/git.vim` | Fugitive + git-gutter (LazyVim-style `<leader>g*`, hunk text objects) |
| `bootstrap.sh` | Symlinks, installs vim-plug, `vim +PlugInstall` |
| `update.sh` | `PlugUpgrade` / `PlugUpdate` (colorscheme is [gruvbox](https://github.com/morhetz/gruvbox) via `vim-plug`) |

## Requirements

- **Vim 8+** or **Neovim** (recent build recommended for plugins)
- **Node.js** (for coc.nvim) — install extensions with `:CocUpdate` in Vim
- **ripgrep** (`rg`, optional) — used for fzf’s file list and `grepprg` when available
- **git** — for `vim-fugitive` / `vim-gitgutter` and the default fzf root behavior

**Plugin directory:** `vim-plug` uses a `plugged/` path chosen in `vimrcs/plugs.vim`: a non-empty `plugged/` next to your resolved `vimrc` (the repo) if one exists, otherwise **Neovim** uses `stdpath('data')/plugged` (often `~/.local/share/nvim/plugged`), and **Vim** uses `~/.vim/plugged`. If you use Neovim and NERDTree (or other plugins) are missing, run **`:PlugInstall`** in the same editor so the bundle matches that path. Errors like `E492: Not an editor command: NERDTreeToggle` usually mean NERDTree is not in `&runtimepath` (wrong or empty `plugged` directory).

## Install

**Warning:** Review this config before you use it. Do not use it blindly.

### Git and `bootstrap.sh`

```bash
git clone https://github.com/dantin/vim-config.git
cd vim-config
./bootstrap.sh
```

`bootstrap.sh` can create `~/.vimrc` → this repo’s `vimrc` and `~/.vim` → the repo, install `autoload/plug.vim` if missing, and run `vim +PlugInstall +qall`.

### After install

- In Vim, run **`:CocUpdate`** to install/upgrade language services (e.g. Pyright, clangd, gopls) per `g:coc_global_extensions` in `vimrcs/coc.vim`.
- For fzf, the `Plug` hook runs `fzf#install()`. A system `fzf` in `PATH` is still fine.

## Documentation

| Doc | Content |
|-----|--------|
| [docs/SPEC.md](docs/SPEC.md) | Dependencies: Vim/Neovim, vim-plug, Node (coc), Git, optional rg / fzf / lazygit / Go, and bootstrap tools |
| [docs/KEYS.md](docs/KEYS.md) | Leader, git (fugitive / gitgutter), coc, fzf, NERDTree |

## Background

This started as a personal [Vim](https://www.vim.org) config. It is now organized into modules so it is easier to keep [coc](https://github.com/neoclide/coc.nvim), fzf, and the rest in sync, inspired in spirit by the [Ultimate vimrc](https://github.com/amix/vimrc) idea of a structured setup.

## Related efforts

- [Ultimate vimrc](https://github.com/amix/vimrc) — early inspiration

## Maintainers

[@dantin](https://github.com/dantin)

## Contributing

Suggestions and improvements are welcome. Feel free to [open an issue](https://github.com/dantin/vim-config/issues/new) or submit a pull request.

## License

[BSD 3-Clause](LICENSE) © David Ding
