" =============================================================================
" Main entry — module layout: vimrcs/
"   options    core editor settings
"   plugs      vim-plug + light plugin vars
"   appearance colorscheme / UI
"   keymaps    leader, windows, NERDTree, buffers
"   coc        LSP / completion
"   fzf        ripgrep + fzf.vim
" =============================================================================

let s:cfg = !empty($MYVIMRC)
      \ ? fnamemodify(resolve(expand($MYVIMRC)), ':h')
      \ : fnamemodify(expand('<sfile>'), ':p:h')

" Persistent undo next to this repo (e.g. ~/.vim/undodir when ~/.vim is this dir)
let s:undod = fnamemodify(s:cfg . '/undodir', ':p')
if !isdirectory(s:undod)
  silent! call mkdir(s:undod, 'p', 0700)
endif
execute 'set undodir=' . fnameescape(s:undod)
set undofile

for s:mod in [
      \ 'options',
      \ 'plugs',
      \ 'appearance',
      \ 'keymaps',
      \ 'coc',
      \ 'fzf',
      \ ]
  execute 'source' fnameescape(s:cfg . '/vimrcs/' . s:mod . '.vim')
endfor
unlet s:mod s:cfg s:undod
