#!/usr/bin/env bash

function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

for i in _*
do
    link_file $i
done

mkdir _vim/bundle
cd _vim/bundle
BUNDLEDIR=`pwd`
rm -rf *

# git clone https://github.com/gabrielelana/vim-markdown.git

git clone https://github.com/Shougo/vimproc.vim.git
cd vimproc.vim
make
cd $BUNDLEDIR
git clone https://github.com/Shougo/unite.vim.git
git clone https://github.com/Shougo/neomru.vim.git
git clone https://github.com/Shougo/neocomplete.vim.git neocomplete
git clone https://github.com/Shougo/neosnippet.vim.git neosnippet
git clone https://github.com/Shougo/neosnippet-snippets.git neosnippet-snippets

git clone https://github.com/ervandew/supertab.git supertab
git clone https://github.com/sjl/gundo.vim.git gundo
git clone https://github.com/scrooloose/syntastic.git syntastic
git clone https://github.com/tpope/vim-fugitive.git vim-fugitive

# YAML
#git clone https://github.com/stephpy/vim-yaml.git
git clone git@github.com:saltstack/salt-vim.git

# Python plugins
git clone https://github.com/mitechie/pyflakes-pathogen.git pyflakes
git clone https://github.com/vim-scripts/pep8.git pep8
git clone https://github.com/davidhalter/jedi-vim.git

# GO plugins
git clone https://github.com/fatih/vim-go.git vim-go

# typescript
# git clone https://github.com/leafgarland/typescript-vim.git typescript-vim

#databases
#git clone https://github.com/vim-scripts/dbext.vim dbext

cd ../..
