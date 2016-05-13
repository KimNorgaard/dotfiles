#!/bin/sh

cd

rm -rf .vim .vimrc .zshrc .tmux.conf .shell

ln -s .dotfiles/vimrc .vimrc
ln -s .dotfiles/vim .vim
ln -s .dotfiles/tmux.conf .tmux.conf
ln -s .dotfiles/zshrc .zshrc
ln -s .dotfiles/zshenv .zshenv
ln -s .dotfiles/shell .shell

mkdir -p .oh-my-ssh/custom/themes
cp .shell/zsh-themes/dracula.zsh-theme .oh-my-ssh/custom/themes/
