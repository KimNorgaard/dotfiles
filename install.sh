#!/bin/sh

cd

rm -rf .vim .vimrc .zshrc .tmux.conf .shell

ln -s .dotfiles/vimrc .vimrc
ln -s .dotfiles/vim .vim
ln -s .dotfiles/tmux.conf .tmux.conf
ln -s .dotfiles/zshrc .zshrc
ln -s .dotfiles/zshenv .zshenv
ln -s .dotfiles/shell .shell
ln -s .dotfiles/pystartup .pystartup
ln -s .dotfiles/gitignore_global .gitignore_global
ln -s .dotfiles/gitconfig .gitconfig
ln -s .dotfiles/pylintrc .pylintrc

mkdir -p .oh-my-zsh/custom/themes
cp .shell/zsh-themes/dracula.zsh-theme .oh-my-zsh/custom/themes/
