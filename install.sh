#!/bin/sh

DIR="$(cd "$( dirname "$0" )" && pwd)"

ln -s $DIR/vim ~/.vim
ln -s $DIR/tmux.conf ~/.tmux.conf
ln -s $DIR/gitconfig ~/.gitconfig
ln -s $DIR/zshrc ~/.zshrc

echo "source $DIR/vimrc" > ~/.vimrc

vim +BundleInstall +qall
