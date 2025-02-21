export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export INPUTRC="$XDG_CONFIG_HOME/inputrc/inputrc"

# Various application settings
export LPASS_AGENT_TIMEOUT=28800
export ANSIBLE_NOCOWS=1
export PYTHONSTARTUP="$HOME/.pystartup"


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

# Print timing for commands that run more that N seconds
export REPORTTIME=5

export GOPATH=~/src/go

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export BROWSER=/Applications/Firefox.app/Contents/MacOS/firefox
#
# Reduce latency when pressing <Esc>
export KEYTIMEOUT=1

export HISTFILE=~/.zsh_history
export HISTORY_IGNORE="(exit|cd|pwd|l[sal]|[bf]g|history|clear)"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--walker-skip .git"
export FZF_ALT_C_OPTS="--walker-skip .git"
export FZF_CTRL_R_OPTS="--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"

export MANPAGER='nvim +Man!'

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

[ -f ${ZDOTDIR}/.env.local ] && source ${ZDOTDIR}/.env.local
