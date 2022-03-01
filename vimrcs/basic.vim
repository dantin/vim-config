"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Basic Settting
"
" Sections:
"
"   -> General
"   -> VIM user interface
"   -> Colors and Fonts
"   -> Files and backups
"   -> Text, tab and indent related
"   -> Visual mode related
"   -> Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

set history=500    " Sets how many lines of history VIM has to remember.

filetype indent on " Enable filetype plugins.
filetype plugin on " Load plugins according to detected filetype.

set autoread       " Set auto read when a file is changed from outside.

let mapleader=","  " With a map leader it's possible todo extra key combinations

" Fast saving, `<leader>w` saves the current file
nmap <leader>w :w!<CR>
" :W sudo saves the file (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null 



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so =6 " Set 6 lines to the cursor - when moving vertically using j/k

" Avoid garbled characters in Chinese language windows OS
let $LANG   ='en'
set langmenu=en
"source $VIMRUNTIME/delmenu.vim  " `:!echo $VIMRUNTIME` to find out
"source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu    " wildmenu add wildmode are used for command line completion
                " Test is with: `:color <TAB>`
                "  * <TAB> forward
                "  * <S-TAB> backword

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set cursorline                  " Find the current line quickly.
set ruler                       " Always show current position.
set cmdheight =2                " Height of the command bar.
set hidden                      " Switch between buffers without having to save first.
set backspace =indent,eol,start " Make backspace work as you would expect.
set whichwrap+=<,>,h,l

set ignorecase    " Ignore case when searching
set smartcase     " When searching try to be smart about case
set hlsearch      " Highlight search results

set lazyredraw    " Don't redraw while executing macros (good performance config)

set magic         " For regular expressions turn magic on

set showmatch     " Show matching brackets when text indicator is over then
set mat   =2      " How many tenths of a second to blink when matching brackets

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

set foldcolumn =1 " Add a bit extra margin on the left



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable                 " Enable syntax highlighting.

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set color scheme
try
    colorscheme monokai       " Prefered color scheme
catch
    colorscheme desert        " Default color schceme
endtry

set background=dark

" Make background transparent
hi! Normal ctermbg=None
hi! NonText ctermbg=None

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set encoding=utf8    " Set utf8 as standard encoding and en_US as the standard language

set ffs=unix,dos,mac " Use Unix as the standard file type



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile
set tags=./.tags;,.tags   " tag file, current directory first, then from parent directory



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab             " Use spaces instead of tabs.
set smarttab              " Be smart when using tabs ;)
set shiftwidth  =4        " >> indents by 4 spaces.
set tabstop     =4        " 1 tab == 4 spaces.

set lbr
set tw =500               " Linebreak on 500 characters.

set ai                    " Auto indent.
set si                    " Smart indent.
set wrap                  " Wrap lines.



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when `<leader><CR>` is pressed.
map <silent> <leader><CR> :noh<CR>

" Smart way to move between windows.
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Return to last edit position when opening files.
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"set autoindent            " Indent according to previous line.
"set softtabstop =4        " Tab key indents by 4 spaces.
"set shiftround            " >> to next multiple of 'shiftwidth'.
"
"set laststatus  =2        " Always show statusline.
"set display     =lastline " Show as much as possible of last line.
"
"set showmode              " Show current mode in command-line
"set showcmd               " Show already typed keys when more are expected.
"
"set ttyfast               " Faster redrawing.
"
"set splitbelow            " Open new windows below the current window.
"set splitright            " Open new windows right of the current window.
"
"set wrapscan              " Searches wrap around end-of-file.
"set report      =0        " Always report changed lines.
"set synmaxcol   =200      " Only highlight the first 200 columns.
"
"set list                  " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
    let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" Put all temporary files under the same directory.
set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo
