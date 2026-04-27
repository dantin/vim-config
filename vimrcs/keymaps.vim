" Leader: must not nnoremap <Space> to <Nop> — a Normal-mode <Space> map
" consumes the key and breaks <Leader>… maps (e.g. <Space>e for NERDTree).
" A single Space in Normal mode may scroll; use a leader prefix for tree, etc.
let g:mapleader = "\<Space>"

" Clear search highlight (Normal mode)
nnoremap <silent> <Esc> :nohlsearch<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <silent> <S-h> :bprevious<CR>
nnoremap <silent> <S-l> :bnext<CR>
nnoremap <silent> <leader>bd :bdelete<CR>

" NERDTree
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
nnoremap <silent> <leader>E :NERDTreeFind<CR>

" Buffers: quick save/quit
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>q :q<CR>
