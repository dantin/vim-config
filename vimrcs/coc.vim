" Avoid hit-enter from coc and language servers
if &cmdheight < 2
  set cmdheight=2
endif

" Extensions installed on :CocInstall (or on first use)
let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-go',
      \ 'coc-json',
      \ 'coc-snippets',
      \ '@yaegassy/coc-ruff',
      \ ]

" Completion: Tab / Shifttab
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Confirm: pair with g:AutoPairsMapCR=0 in plugs
inoremap <silent><expr> <CR> coc#pum#visible()
      \ ? coc#pum#confirm()
      \ : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" LSP jump (gd / gr / gy / gi)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)

" Hover on K
function! s:ShowDocumentation() abort
  if index(['vim', 'help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  elseif CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent> K :call <SID>ShowDocumentation()<CR>

" Refactor
nmap <leader>cr <Plug>(coc-rename)
xmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>ca <Plug>(coc-codeaction-cursor)
nmap <leader>cf <Plug>(coc-format)

" Diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
nmap <silent> <leader>cd <Plug>(coc-diagnostic-info)
