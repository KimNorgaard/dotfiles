#!/bin/bash
DOTFILES=$HOME/.dotfiles

link_it() {
  if [ "x$2" = "x" ]; then
    DST="$HOME/.$1"
  else
    DST=$2
  fi
  ln -sf $DOTFILES/$1 $DST
}

cd

mkdir -p .config

# don't remove .vim/tmp and .mutt/temp
# or move data out of there - also for mutt
#rm -rf .vim .shell .mutt .config/gtk-3.0

cd $DOTFILES/bin

# Scripts
(
    for f in *; do
      link_it bin/$f $HOME/bin/$f
    done
)

cd

# Git
link_it gitconfig
link_it gitignore_global
sudo ln -sf $HOME/bin/git-credential-helper.sh /usr/local/bin/git-credential-helper.sh

# Vim
link_it vimrc
link_it vim
ln -sf $HOME/.config/nvim $HOME/.vim

# Mail
link_it muttrc
link_it mutt
mkdir -p .mutt/temp
link_it mbsyncrc
link_it msmtprc
link_it notmuch-config

# Shell
link_it zshrc
link_it zshenv
link_it shell
link_it tmux.conf

# Dev
link_it flake8
link_it pystartup
link_it pylintrc

# X
link_it cdmrc
link_it gtkrc-2.0
link_it gtk-3.0 $HOME/.config/gtk-3.0
link_it Xresources
link_it xinitrc
link_it Xmodmap
link_it xserverrc
link_it i3 $HOME/.config/i3
link_it i3status.conf

# Misc
link_it asoundrc
link_it todo.cfg


#TODO: symlink .config/fontconfig/conf.d/10-sub-pixel-rgb.conf
#TODO: symlink .config/fontconfig/conf.d/11-lcdfilter-default.conf
