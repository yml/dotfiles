#!/usr/bin/env bash
function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

if [ "$1" = "vim" ]; then
    for i in _vim*
    do
       link_file $i
    done
else
    for i in _*
    do
        link_file $i
    done
fi

mkdir _vim/bundle
cd _vim/bundle
rm -rf *

git clone https://github.com/drmingdrmer/xptemplate
# symlink local bundle xpt-personal
ln -sf ../xpt-personal xpt-personal
git clone https://github.com/gabrielelana/vim-markdown.git
git clone https://github.com/Shougo/vimproc.vim.git
cd bundle/vimproc.vim
make
cd ../..
git clone https://github.com/Shougo/unite.vim.git
git clone https://github.com/Shougo/neomru.vim.git
git clone https://github.com/ervandew/supertab.git supertab
git clone https://github.com/sjl/gundo.vim.git gundo
git clone https://github.com/vim-scripts/The-NERD-tree.git nerdtree
git clone https://github.com/scrooloose/syntastic.git syntastic

# Python plugins
git clone https://github.com/mitechie/pyflakes-pathogen.git pyflakes
git clone https://github.com/vim-scripts/pep8.git pep8
git clone https://github.com/davidhalter/jedi-vim.git

# GO plugins
git clone https://github.com/fatih/vim-go.git vim-go

# typescript
git clone https://github.com/leafgarland/typescript-vim.git typescript-vim

cd ../..
