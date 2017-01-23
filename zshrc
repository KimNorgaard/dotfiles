# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="minimal"
#ZSH_THEME="simple"
ZSH_THEME="dracula"

source ~/.shell/aliases
source ~/.shell/func

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git jira)

source $ZSH/oh-my-zsh.sh

PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/MacGPG2/bin:~/bin
export PATH


LANG=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
export EDITOR=nvim
export PAGER=less
export LESS='-RM' 

# Always use menu completion, and make the colors pretty!
zstyle ':completion:*' menu select yes
zstyle ':completion:*:default' list-colors ''

REPORTTIME=5

export POOLPL_SERVER="https://stingray01.netic.dk:9090"

if [ -d $HOME/perl5 ]; then
  eval $(/usr/bin/perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)
fi

export ANSIBLE_NOCOWS=1
#export VIRTUAL_ENV_DISABLE_PROMPT=1
#
export PYTHONSTARTUP="$HOME/.pystartup"

export JIRA_URL=https://jira.netic.dk

export TODOTXT_DEFAULT_ACTION=ls

export ZENHEST_URL=http://zen01.netic.dk:8080
export ZENHEST_USER=$(whoami)

export LPASS_AGENT_TIMEOUT=28800

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
