#!/bin/bash

# install vim-plug
if [[ ! -e ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cd ~
type nvim > /dev/null 2>&1 && rm -rf .config/nvim && ln -s ~/.vim .config/nvim
type nvim > /dev/null 2>&1 && nvim +PlugInstall +qall || vim +PlugInstall +qall

cd ~/.vim
[[ ! -f init.vim ]] && ln -s vimrc init.vim

[[ ! -d cache ]] && mkdir cache
