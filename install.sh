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

# Install rope, ropemode, ropevim globally
# sudo pip install -U rope ropemode ropevim

mkdir _vim/bundle
cd _vim/bundle
rm -rf *
git clone https://github.com/ervandew/supertab.git supertag
git clone https://github.com/tomtom/tlib_vim.git tlib
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git vim-addon-mw-utils
git clone https://github.com/garbas/vim-snipmate.git snipmate
git clone https://github.com/sontek/minibufexpl.vim.git minibufexpl
git clone https://github.com/mitechie/pyflakes-pathogen.git pyflakes
git clone https://github.com/sjl/gundo.vim.git gundo
git clone https://github.com/vim-scripts/pep8.git pep8
git clone https://github.com/vim-scripts/The-NERD-tree.git nerdtree
git clone https://github.com/kien/ctrlp.vim.git ctrlp
git clone https://github.com/uggedal/go-vim go-vim
git clone https://github.com/dgryski/vim-godef godef
git clone https://github.com/Raimondi/delimitMate.git delimitMate
cd ../..
