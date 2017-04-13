PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/MacGPG2/bin:~/bin:$GOPATH/bin
export PATH

LANG=en_US.UTF-8
LC_CTYPE=en_US.UTF-8

setopt noautomenu
setopt nomenucomplete
source ~/.shell/aliases
source ~/.shell/func
source ~/.shell/autocomplete.zsh
source ~/.shell/prompt.zsh
source ~/.shell/history.zsh

#setopt +o menucomplete

bindkey -e

# zsh
#fpath=(/home/kn/src/lpasszsh $fpath)

if [ -d $HOME/perl5 ]; then
  eval $(/usr/bin/perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)
fi

if [ -e "${HOME}/.iterm2_shell_integration.zsh" ]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi

if which ponysay > /dev/null; then
  ponysay -q
fi

PATH="/home/kn/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/kn/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/kn/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/kn/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/kn/perl5"; export PERL_MM_OPT;
