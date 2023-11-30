#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=/opt/homebrew/bin:${PATH}:~/netic-bin:~/.local/bin:~/bin

export ANSIBLE_NOCOWS=1
export PYTHONSTARTUP="$HOME/.pystartup"

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LPASS_AGENT_TIMEOUT=28800
export BROWSER=firefox
export LESS='-RM'
export LESS_TERMCAP_mb=$'\E[01;31m'             # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'        # begin bold
export LESS_TERMCAP_me=$'\E[0m'                 # end mode
export LESS_TERMCAP_se=$'\E[0m'                 # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'          # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m'       # begin underline
export TERMINAL=alacritty
export REPORTTIME=5
export PROJECT_HOME=~/src
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export GOPATH=~/src/go

[ -f ~/.env.local ] && source ~/.env.local

alias vi=nvim
alias ovi="\vi"
alias vim=nvim
alias ovim="\vim"
alias vimdiff="nvim -d"
alias open=xdg-open
alias netctl='sudo netctl'
alias ls='ls --color=auto -F'
alias ll='ls -lFh'
alias lla='ls -lFhA'
alias llrt='ls -lFhArt'

alias k=kubectl
alias tf=terraform
alias g=git
alias lg=lazygit
alias gp='git pull'
alias gP='git push'
alias gits='git status -s'
alias clock='tty-clock -b -c -C 6 -f \"%A %d/%m/%y\" -B -a 100000000 -d 0'

alias novpn='/opt/cisco/anyconnect/bin/vpn disconnect'

alias dockerledger="docker run --rm -it -e LEDGER_FILE=/data/main.ldg -v /home/kn/data/accounting/:/data --user $UID knhlg bash"

function CONFIG() {
   /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" $@
}

function parse_git_dirty() {
   local yellow=$'\001\e[33m\002'
   [[ -n $(git status --porcelain --ignore-submodules=dirty 2>/dev/null) ]] && echo -n "${yellow}*"
}

function parse_git_info() {
   local ref
   local color=$'\001\e[36m\002'

   ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
      ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
   ref=${ref#refs/heads/}
   dirty=$(parse_git_dirty)
   echo -n " ${color}(${ref}${dirty}${color})"
}

function __prompt_command() {
   local exit="$?"

   local reset=$'\001\e[0m\002'
   local blue=$'\001\e[34m\002'
   local red=$'\001\e[31m\002'

   local ret=''
   if [ $exit -eq 0 ]; then
      ret=$blue
   else
      ret=$red
   fi

   local git_info
   git_info=$(parse_git_info)

   PS1="\t ${ret}\w${git_info}${reset} "
}

# Record each line as it gets issued
PROMPT_COMMAND='__prompt_command; history -a; history -n'

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
# CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
# shopt -s cdable_vars

# source /usr/share/fzf/key-bindings.bash
# source /usr/share/fzf/completion.bash
source "/opt/homebrew/opt/fzf/shell/completion.bash"
source "/opt/homebrew/opt/fzf/shell/key-bindings.bash"

export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# not in a TMUX session but in an X session
if [ -z ${TMUX} ] && [ -n "${DISPLAY}" ]; then
    (tmux ls | grep -vq attached && exec tmux -2 at) || exec tmux -2
fi

