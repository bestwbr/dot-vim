#!/bin/bash

# install vim-plug
if [[ ! -e ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cd ~
type nvim > /dev/null 2>&1 && rm -rf .config/nvim && ln -s ~/.vim .config/nvim
type nvim > /dev/null 2>&1 && nvim +PlugInstall +qall || vim +PlugInstall +qall

# compile YouCompleteMe
cd ~/.vim/plugged/YouCompleteMe
type cargo > /dev/null 2>&1 && RUST="--rust-completer" || RUST=""
python install.py --clang-completer $RUST
cd -
