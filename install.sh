#!/bin/sh

ln -s vim ~/.vim
ln -s tmux.conf ~/.tmux.conf
ln -s gitconfig ~/.gitconfig
ln -s zshrc ~/.zshrc

echo "source $PWD/vimrc" > ~/.vimrc
