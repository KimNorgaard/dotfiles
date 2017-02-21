source ~/.shell/aliases
source ~/.shell/func
source ~/.shell/autocomplete.zsh
source ~/.shell/prompt.zsh
source ~/.shell/history.zsh

# zsh
#fpath=(/home/kn/src/lpasszsh $fpath)

if [ -d $HOME/perl5 ]; then
  eval $(/usr/bin/perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)
fi

if [ -e "${HOME}/.iterm2_shell_integration.zsh" ]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi
