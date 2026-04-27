" Defer <CR> handling to coc when completion is active (auto-pairs is loaded here)
let g:AutoPairsMapCR = 0

call plug#begin('~/.vim/plugged')

" LSP and completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Syntax and editing
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Go: buffers & commands; gopls disabled when coc handles LSP
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" UI
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

" Fuzzy find (post-install: works without +lambda; see vim-plug `do` hook)
Plug 'junegunn/fzf', { 'do': 'call fzf#install()' }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

" Rely on coc (coc-go) for gopls; avoid duplicate gopls from vim-go
let g:go_gopls_enabled = 0
let g:go_def_mapping_enabled = 0

" Airline: set to 1 if you use a patched Nerd / Powerline font
let g:airline_powerline_fonts = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 0

" NERDTree
let g:NERDTreeShowHidden = 0
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', '^\.git$']
let g:NERDTreeAutoDeleteBuffer = 1

