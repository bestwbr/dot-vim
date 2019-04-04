#!/bin/bash

# install vim-plug
if [[ ! -e ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# compile YouCompleteMe
cd ~/.vim/plugged/YouCompleteMe
./install.sh --clang-completer --rust-completer
cd -
