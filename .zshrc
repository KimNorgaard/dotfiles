# DIRECTORIES
setopt AUTO_CD                # Auto cd into directories
setopt AUTO_PUSHD             # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS      # Do not store duplicates in the stack.
setopt PUSHD_SILENT           # Do not print the directory stack after pushd or popd.
# COMPLETION
setopt ALWAYS_TO_END          # Move cursor to the end of a completed word.
setopt AUTO_LIST              # Automatically list choices on ambiguous completion.
setopt AUTO_MENU              # Show completion menu on a succesive tab press.
setopt AUTO_PARAM_SLASH       # If completed parameter is a directory, add a trailing slash.
setopt NO_MENU_COMPLETE       # Do not autoselect the first completion entry.
# EXPANSION AND GLOBBING
setopt EXTENDED_GLOB          # Enable additional glob operators
# HISTORY
setopt EXTENDED_HISTORY       # Save timestamp and duration
setopt HIST_EXPIRE_DUPS_FIRST # Delete oldest duplicates from hitory first
setopt HIST_FIND_NO_DUPS      # Do not display duplicates of a line previously found
setopt HIST_FCNTL_LOCK        # Use modern file-locking mechanisms, for better safety & performance.
setopt HIST_IGNORE_ALL_DUPS   # Keep only the most recent copy of each duplicate entry in history.
setopt HIST_IGNORE_DUPS       # Do not enter command lines into the history list if they are duplicates of the previous event
setopt HIST_IGNORE_SPACE      # Remove command lines from the history list when the first character on the line is a space
setopt HIST_VERIFY            # Perform history expansion and reload the line into the editing buffer
setopt INC_APPEND_HISTORY     # Add new history lines to the $HISTFILE incrementally
setopt SHARE_HISTORY          # Imports new commands from the history file and causes typed commands to be appended to the history file
# INPUT/OUTPUT
setopt NO_CLOBBER             # Don'w allow > to overwrite (use >! or >|)
setopt CLOBBER_EMPTY          # Allow to clobber empty files
setopt CORRECT                # Correct spelling of commands
setopt NO_FLOW_CONTROL        # Disable start/stop characters in shell editor.
setopt PATH_DIRS              # Perform path search even on command names with slashes.
setopt INTERACTIVE_COMMENTS   # Allow comments in interactive shells
# PROMPTING
setopt PROMPT_SUBST           # Perform parameter expansion, command substitution, etc in prompts

SAVEHIST=100000
HISTSIZE=120000

alias g=git
alias gP='git push'
alias gits='git status -s'
alias gp='git pull'
alias history='fc -l 1'
alias k=kubectl
alias lg=lazygit
alias ll='ls -lFh'
alias lla='ls -lFhA'
alias llrt='ls -lFhArt'
alias lpcp='lpass show -c --password'
alias ls="ls --color=auto -F"
alias ovi="\vi"
alias ovim="\vim"
alias tf=terraform
alias vi=nvim
alias vim=nvim
alias vimdiff="nvim -d"
# http verbs
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="curl -X \"$method\""
done
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index # directory stack

# AUTOCOMPLETION
autoload -Uz compinit; compinit
autoload -U bashcompinit; bashcompinit

# Enable approximate completions
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors based on the length of the typed word.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'

# Group results by category
zstyle ':completion:*' group-name ''

# Don't insert a literal tab when trying to complete in an empty buffer
zstyle ':completion:*' insert-tab false

# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true

zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w -w'

# Nicer format for completion messages
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'

# Show message while waiting for completion
zstyle ':completion:*' show-completer true

# Auto rehash
zstyle ':completion:*' rehash true

autoload -Uz colors && colors

function parse_git_dirty() {
  [[ -n $(git status --porcelain --ignore-submodules=dirty 2>/dev/null) ]] && echo -n "%{$fg[yellow]%}*"
}

function git_prompt_info() {
    local branch
    branch=$(command git rev-parse --abbrev-ref HEAD 2>/dev/null) || return 0

    # echo -n "%{$fg[brred]%}${branch}$(parse_git_dirty)%{$reset_color%} "
    echo -n "%F{9}${branch}$(parse_git_dirty)%{$reset_color%} "
}

VIMODE=""

current_dir() {
    echo -n "%{$fg[white]%}%c "
}

return_status() {
  echo -n "%(?.%F{green}.%F{red})❯%f "
}

bg_jobs() {
  bg_status="%{$fg[yellow]%}%(1j.↓%j .)"
  echo -n $bg_status
}

readonly PS1_TEMPLATE='${VIMODE}$(current_dir)$(git_prompt_info)$(bg_jobs)$(return_status)'

PS1="${PS1_TEMPLATE}"

# Vim key bindings
bindkey -v

# Map 'v' to edit-command-line in vicmd
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# enable emacs bindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^U" kill-whole-line
bindkey "^W" backward-kill-word
bindkey "^Y" yank

function zle-line-init() {
  zle -K viins
}
zle -N zle-line-init

function zle-keymap-select {
  VIMODE="${${KEYMAP/vicmd/[NORMAL] }/(main|viins)/}"
  PS1="${PS1_TEMPLATE}"
  if [ $KEYMAP = vicmd ]; then
      echo -ne '\e[2 q'
  else
      echo -ne '\e[6 q'
  fi
  zle reset-prompt
}
zle -N zle-keymap-select

eval "$(fzf --zsh)"

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
