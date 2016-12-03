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
ln -s .dotfiles/muttrc .muttrc
ln -s .dotfiles/Xresources .Xresources
ln -s .dotfiles/i3 .i3
ln -s .dotfiles/xinitrc .xinitrc
ln -s .dotfiles/Xmodmap .Xmodmap
ln -s .dotfiles/gtkrc-2.0 .gtkrc-2.0

#mkdir -p .mutt
##for f in mailcap offlineimap.py quicklook.sh sig view_attachment.sh; do
#  ln -s .dotfiles/mutt/$f .mutt/$f
#done

#chmod 755 .mutt/offlineimap.py .mutt/quicklook.sh .mutt/view_attachment.sh

mkdir -p .oh-my-zsh/custom/themes
cp .shell/zsh-themes/dracula.zsh-theme .oh-my-zsh/custom/themes/
