"
" A (not so) minimal vimrc.
"
set runtimepath+=~/.vim
for f in split(glob('~/.vim/vimrcs/*.vim'), '\n')
    exec 'source' f
endfor
