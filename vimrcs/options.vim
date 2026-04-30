" === Core editing & display ===
set encoding=utf-8                         " use UTF-8 for buffer text and scripts
set fileformats=unix,dos,mac               " try these line-ending styles when reading files
set number                                 " show absolute line numbers in the gutter
set relativenumber                         " line numbers relative to cursor (with number: hybrid)
set cursorline                             " highlight the line containing the cursor
set scrolloff=4                            " keep at least N lines visible above/below cursor
set sidescrolloff=4                        " keep at least N columns visible left/right of cursor
set showcmd                                " show incomplete Normal-mode commands in status line
set showmode                               " show current mode (INSERT, VISUAL, …) in command line
set wildmenu                               " enhanced menu for command-line completion (<Tab>)
set incsearch                              " jump to matches while typing a search pattern
set hlsearch                               " highlight all matches of the last search
set updatetime=300                         " ms before CursorHold events and swap write (affects plugins)

" Indent: spaces by default; Go uses tabs (see autocmd below)
set expandtab                              " insert spaces when Tab is pressed (not literal tab chars)
set tabstop=4                              " width (columns) of a literal tab character on screen
set shiftwidth=4                           " indent step for >>, <<, =, and automatic C indenting
set softtabstop=4                          " columns inserted when Tab/BS in Insert mode (with expandtab)
set shiftround                             " round indent to a multiple of shiftwidth when shifting
set autoindent                             " copy indent from previous line on new line
set smartindent                            " extra indent rules for C-like syntax (pairs with autoindent)
set linebreak                              " wrap long lines at characters in breakat (not mid-word if possible)
set breakindent                            " indent wrapped lines to align with the start of the text

set termguicolors                          " use 24-bit GUI colors in the terminal (true color)
syntax on                                  " enable syntax highlighting
filetype plugin indent on                  " detect filetype; load ftplugin and indent scripts

if exists('+signcolumn')
  " only if this Vim build supports signcolumn (Neovim/modern Vim) show sign column when needed (errors, marks, git, …)
  set signcolumn=auto
endif
set clipboard=unnamedplus                  " use system clipboard (+ register) for yank/paste when unnamed
set mouse=a                                " enable mouse in all modes (visual, normal, insert, …)
set hidden                                 " allow switching buffers without saving (keep unsaved in background)
set pumheight=12                           " max height of insert-mode completion popup menu
set shortmess+=c                           " suppress ins-completion menu messages in command line
set belloff=all                            " never ring bell or flash on errors/events
set backspace=indent,eol,start             " allow Backspace over autoindent, line joins, and before insert start

" undodir / undofile: set in top-level vimrc

" Go: official style uses tabs
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4  " Go: real tabs, width 4 (gofmt style)
autocmd FileType json setlocal shiftwidth=2 tabstop=2 expandtab  " JSON
