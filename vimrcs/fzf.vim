if executable('rg')
  let g:rg_derive_root = 'true'
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*" --glob "!node_modules/*"'
  set grepprg=rg\ --vimgrep\ --smart-case
endif

" Search & navigation (LazyVim-style)
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>sg :Rg<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fr :History<CR>
nnoremap <silent> <leader>sc :History:<CR>
nnoremap <silent> <leader>/ :BLines<CR>
