filetype on
filetype plugin indent on
syntax on
set nu
set mouse=a
"set selection=exclusive
set selectmode=key
set showmatch
set paste
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab

set ai
set si

set hlsearch
set incsearch

set showcmd

"vim vtags setting
source ~/install/vtags-3.10/vtags_vim_api.vim

:ab shixu always@(posedge clk or negedge rst_n)<Enter>begin<Enter>if (!rst_n)<Enter> end
:ab zuhe always@()



".v files header auto create and update
map <F4> :call TitleDet()<cr>'s
function AddTitle()
    call append(0,"/*******************************************")
    call append(1,"# Author       : Wenao Xie")
    call append(2,"# Create Time  : ".strftime("%Y-%m-%d %H:%M"))
    call append(3,"# Last modified: ".strftime("%Y-%m-%d %H:%M"))
    call append(4,"# Filename     : ".expand("%:t"))
    call append(5,"# Description  : ")
    call append(6,"# Version      : ")
    call append(7,"********************************************/")
  echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf
"更新最近修改时间和文件名
function UpdateTitle()
    normal m'
    execute '/# *Last modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
    normal ''
    normal mk
execute '/# *Filename     :/s@:.*$@\=": ".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
    endfunction
    "判断前16行代码里面，是否有Last modified这个单词，
    "如果没有的话，代表没有添加过作者信息，需要新添加；
    "如果有的话，那么只需要更新即可
function TitleDet()
    let n=1
    "默认为添加
    while n < 8
        let line = getline(n)
        if line =~ '^\#\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction
