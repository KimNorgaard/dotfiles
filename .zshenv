export XDG_CONFIG_HOME="$HOME/.config"
source $XDG_CONFIG_HOME/shell/env
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Print timing for commands that run more that N seconds
export REPORTTIME=5

# Reduce latency when pressing <Esc>
export KEYTIMEOUT=1
export HISTFILE=~/.zsh_history
export HISTORY_IGNORE="(exit|cd|pwd|l[sal]|[bf]g|history|clear)"

[ -f ~/.env.local ] && source ~/.env.local

