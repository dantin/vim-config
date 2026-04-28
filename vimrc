" =============================================================================
" Main entry — module layout: vimrcs/
"   options    core editor settings
"   plugs      vim-plug + light plugin vars
"   appearance colorscheme / UI
"   keymaps    leader, windows, NERDTree, buffers
"   coc        LSP / completion
"   fzf        ripgrep + fzf.vim
"   git        fugitive + gitgutter (LazyVim-style <leader>g* / ]h)
" =============================================================================

let s:cfg = !empty($MYVIMRC)
      \ ? fnamemodify(resolve(expand($MYVIMRC)), ':h')
      \ : fnamemodify(expand('<sfile>'), ':p:h')
" Where plug#begin() looks: see vimrcs/plugs.vim
let g:vimrc_config_dir = s:cfg

" Persistent undo next to this repo (e.g. ~/.vim/undodir when ~/.vim is this dir)
let s:undod = fnamemodify(s:cfg . '/undodir', ':p')
if !isdirectory(s:undod)
  silent! call mkdir(s:undod, 'p', 0700)
endif
execute 'set undodir=' . fnameescape(s:undod)
set undofile

" Scripted :PlugInstall (install.sh): no real TTY; skip UI/LSP layers or Vim waits on
" -- More -- / coc startup / prompts with no stdin. See VIM_PLUG_BOOTSTRAP in install.sh.
if $VIM_PLUG_BOOTSTRAP ==# '1'
  let s:modlist = ['options', 'plugs']
else
  let s:modlist = [
        \ 'options',
        \ 'plugs',
        \ 'appearance',
        \ 'keymaps',
        \ 'coc',
        \ 'fzf',
        \ 'git',
        \ ]
endif

for s:mod in s:modlist
  execute 'source' fnameescape(s:cfg . '/vimrcs/' . s:mod . '.vim')
endfor
unlet s:mod s:cfg s:undod s:modlist
