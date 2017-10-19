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
ln -sf $(pwd)/_vimrc $HOME/.config/nvim/init.vim
