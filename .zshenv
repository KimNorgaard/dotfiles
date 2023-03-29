export ANSIBLE_NOCOWS=1
export PYTHONSTARTUP="$HOME/.pystartup"
export TODOTXT_DEFAULT_ACTION=ls

export LPASS_AGENT_TIMEOUT=28800

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

export LESS='-RM'
export LESS_TERMCAP_mb=$'\E[01;31m'             # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'        # begin bold
export LESS_TERMCAP_me=$'\E[0m'                 # end mode
export LESS_TERMCAP_se=$'\E[0m'                 # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'          # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m'       # begin underline

export TERMINAL=termite

export REPORTTIME=5

export GOPATH=~/src/go

export PROJECT_HOME=~/src

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export BROWSER=firefox

[ -f ~/.env.local ] && source ~/.env.local

#AWSume alias to source the AWSume script
alias awsume=". awsume"

#Auto-Complete function for AWSume
#Auto-Complete function for AWSume
fpath=(~/.awsume/zsh-autocomplete/ ~/.zsh/autocomp $fpath)
