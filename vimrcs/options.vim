" === Core editing & display ===
set encoding=utf-8
set fileformats=unix,dos,mac
set number
set relativenumber
set cursorline
set scrolloff=4
set sidescrolloff=4
set showcmd
set showmode
set wildmenu
set incsearch
set hlsearch
set updatetime=300

" Indent: spaces by default; Go uses tabs (see autocmd below)
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set autoindent
set smartindent
set linebreak
set breakindent

set termguicolors
syntax on
filetype plugin indent on

if exists('+signcolumn')
  set signcolumn=auto
endif
set clipboard=unnamedplus
set mouse=a
set hidden
set pumheight=12
set shortmess+=c
set belloff=all
set backspace=indent,eol,start

" undodir / undofile: set in top-level vimrc

" Go: official style uses tabs
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
