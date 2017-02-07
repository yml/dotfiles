#!/usr/bin/env bash

function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

# Link all the files that starts by `_` and create a symlink into $HOME
for i in _*
do
    if [ -f $i ]; then
        link_file $i
    fi
done

# Link pip and vim 
for i in "_pip" "_vim"
do
    if [ -d $i ]; then
        link_file $i
    fi
done

# Link nvim
mkdir -p $HOME/.config/nvim
ln -sf $(pwd)/_config/nvim/init.vim $HOME/.config/nvim/init.vim


mkdir _vim/bundle
cd _vim/bundle
BUNDLEDIR=`pwd`
rm -rf *

# git clone https://github.com/gabrielelana/vim-markdown.git


git clone https://github.com/sjl/gundo.vim.git gundo
git clone https://github.com/scrooloose/syntastic.git syntastic
git clone https://github.com/tpope/vim-fugitive.git vim-fugitive

# YAML
#git clone https://github.com/stephpy/vim-yaml.git
#git clone git@github.com:saltstack/salt-vim.git

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
