"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Basic Settting
"
" Sections:
"
"   -> Vim-plug
"   -> Nerd Tree
"   -> lightline
"   -> LeaderF
"   -> YouCompleteMe
"   -> vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
call plug#end()


""""""""""""""""""""""""""""""
" => Nerd Tree
""""""""""""""""""""""""""""""
let g:NERDTreeWinPos   ="left"
let NERDTreeShowHidden =0
let NERDTreeIgnore     = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize  =35

map <leader>nn :NERDTreeToggle<CR>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<CR>


""""""""""""""""""""""""""""""
" => lightline
""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['paste'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }


""""""""""""""""""""""""""""""
" => LeaderF
""""""""""""""""""""""""""""""
let g:Lf_ShortcutF = '<c-p>'
"let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
noremap <leader>f :LeaderfFunction!<cr>
"noremap <m-n> :LeaderfBuffer<cr>
"noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}


""""""""""""""""""""""""""""""
" => YouCompleteMe
""""""""""""""""""""""""""""""
"let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_confrm_extra_conf=0
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"
set completeopt=longest,menu

" NOTE: Key conflict with UltiSnips and YouCompleteMe
"       solution: https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme/22253548#22253548
"
"" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
"
"" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


""""""""""""""""""""""""""""""
" => Go-lang support
""""""""""""""""""""""""""""""

" automatically wite file when call :GoBuild
set autowrite

" whenever you save the file, `goimports` will automatically format and also
" rewrite the import declarations.
" TLDR; `goimports` is a replacement for `gofmt`.
let g:go_fmt_command = "goimports"
" style
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
" Enable linting
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['golint']

autocmd FileType go map <C-n> :cnext<CR>
autocmd FileType go map <C-m> :cprevious<CR>
autocmd FileType go nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
