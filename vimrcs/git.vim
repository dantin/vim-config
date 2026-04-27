" === LazyVim-style git: vim-fugitive + vim-gitgutter ===
" See docs/KEYS.md

" — tpope/vim-fugitive (aligned with LazyVim snacks + general <leader>g* git entries) —

" Git / status
nnoremap <silent> <leader>gs :<C-u>Git<CR>
" Stash
nnoremap <silent> <leader>gS :<C-u>Git! stash<CR>
" Blame
nnoremap <silent> <leader>gb :<C-u>Gblame<CR>
" Diff: working tree vs index
nnoremap <silent> <leader>gd :<C-u>Gvdiff<CR>
" Diff: vs merge-base of upstream
nnoremap <silent> <leader>gD :<C-u>Gvdiffsplit! @{u}<CR>
" Log: all commits (repo)
nnoremap <silent> <leader>gl :<C-u>Glog<CR>
" Log: cwd — shell pager (portable; LazyVim uses snacks picker when available)
nnoremap <silent> <leader>gL :<C-u>!git log<CR>
" File history
nnoremap <silent> <leader>gf :<C-u>0Glog<CR>
" :GBrowse needs tpope/vim-rhubarb for GitHub URLs; add manually if you use it:
" nnoremap <silent> <leader>gB :<C-u>GBrowse<CR>
" nnoremap <silent> <leader>gY :<C-u>GBrowse! @:<C-r>+<CR>

" — airblade/vim-gitgutter (g:gitgutter_map_keys = 0 in plugs) —

nmap <silent> [h <Plug>(GitGutterPrevHunk)
nmap <silent> ]h <Plug>(GitGutterNextHunk)
nmap <silent> <leader>ghp <Plug>(GitGutterPreviewHunk)
nmap <silent> <leader>ghs <Plug>(GitGutterStageHunk)
" Reset hunk in buffer (Gitsigns: <leader>ghr)
nmap <silent> <leader>ghr <Plug>(GitGutterUndoHunk)
" Unstage whole file
nnoremap <silent> <leader>ghu :<C-u>Git! reset HEAD -- %<CR>
" Stage / discard buffer
nnoremap <silent> <leader>ghS :<C-u>Git! add %<CR>
nnoremap <silent> <leader>ghR :<C-u>Git! restore %<CR>
" Hunk / buffer diff: gitgutter diff; vs parent revision
nnoremap <silent> <leader>ghd :<C-u>GitGutterDiffOrig<CR>
nnoremap <silent> <leader>ghD :<C-u>Gvdiffsplit! HEAD^<CR>
" Hunk text objects (ic/ac in :h gitgutter; LazyVim gitsigns: ih/ah)
onoremap <silent> ih <Plug>(GitGutterTextObjectInnerPending)
onoremap <silent> ah <Plug>(GitGutterTextObjectOuterPending)
xnoremap <silent> ih <Plug>(GitGutterTextObjectInnerVisual)
xnoremap <silent> ah <Plug>(GitGutterTextObjectOuterVisual)
" Blame (Gitsigns: ghb)
nnoremap <silent> <leader>ghb :<C-u>Gblame<CR>

" — optional: lazygit (snacks / extras-style gg / gG) —
if executable('lazygit')
  nnoremap <silent> <leader>gg :<C-u>!lazygit<CR>
  nnoremap <silent> <leader>gG :<C-u>lcd %:p:h<bar>!lazygit<CR>
endif
