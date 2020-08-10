# LOCALE
LANG=en_US.UTF-8
LC_CTYPE=en_US.UTF-8

setopt noautomenu
setopt nomenucomplete

# ALIASES
# vim
which nvim > /dev/null
if [ $? -eq 0 ]; then
  #alias vim="TERM=xterm-256color nvim"
  #alias vi="TERM=xterm-256color nvim"
  alias vim=nvim
  alias ovim="\vim"
  alias vimdiff="nvim -d"
else
  alias vi=vim
fi

# misc
alias open=xdg-open
alias netctl='sudo netctl'
alias history='fc -l 1'
alias ls='ls -F'

# clipboard
alias yy='xsel -i -b'
alias p='xsel -b'

# ls
alias ll='ls -lFh'
alias lla='ls -lFhA'
alias llrt='ls -lFhArt'

alias gcloud='docker run -ti --volumes-from gcloud-config google/cloud-sdk gcloud'

alias kb=kubectl
alias tf=terraform
alias gp='git pull'
alias gP='git push'

# http verbs
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="curl -X \"$method\""
done

# FUNCTIONS
_has(){
   return $( whence $1 >/dev/null )
}

alias vpn='/opt/cisco/anyconnect/bin/vpn connect "Netic tech profile"'
alias novpn='/opt/cisco/anyconnect/bin/vpn disconnect'

function ovpn() {
  sudo -- openconnect --config $VPN_CONFIG \
                      --syslog \
                      --pid-file=/var/run/openconnect.pid \
                      --background $VPN_SERVER || return
  sleep 2
  devid=$(ip -o link show tun0 | cut -d" " -f1 | tr -d :)
  sudo busctl call org.freedesktop.resolve1 /org/freedesktop/resolve1 org.freedesktop.resolve1.Manager SetLinkDNS 'ia(iay)' $devid 2 2 4 77 243 50 250 2 4 77 243 50 251
  dunstify -i connect_established \
           -u normal "VPN Connected$VPN_SERVER"
}

function noovpn() {
  if [ -f /var/run/openconnect.pid ]; then
    sudo kill -INT $(cat /var/run/openconnect.pid)
  fi
  sleep 2
  dunstify -i connect_no \
           -t 8000 \
           -u critical "VPN Disconnected$VPN_SERVER"
}

function lsp() {
  # clipster -i
  lpass show --clip --password $(lpass ls  | fzf | awk '{print $(NF)}' | sed 's/\]//g')
}

function CONFIG() {
   /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" $@
}

function onmodify() {
    TARGET=${1:-.}; shift
    CMD="$@"

    echo "$TARGET" "$CMD"
    while inotifywait --exclude '.git' -qq -r -e close_write,moved_to,move_self $TARGET; do
        sleep 0.2
        bash -c "$CMD"
        echo
    done
}

# AUTOCOMPLETION
autoload -Uz compinit
compinit

setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a succesive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

if [ -d ~/src/kn/lpasszsh ]; then
  autoload -U ~/src/kn/lpasszsh/*(:t)
fi

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
zstyle ':completion:*' list-colors 'rs=0' 'di=01;34' 'ln=01;36' 'mh=00' 'pi=40;33' 'so=01;35' 'do=01;35' 'bd=40;33;01' 'cd=40;33;01' 'or=40;31;01' 'mi=00' 'su=37;41' 'sg=30;43' 'ca=30;41' 'tw=30;42' 'ow=34;42' 'st=37;44' 'ex=01;32' '*.tar=01;31' '*.tgz=01;31' '*.arc=01;31' '*.arj=01;31' '*.taz=01;31' '*.lha=01;31' '*.lz4=01;31' '*.lzh=01;31' '*.lzma=01;31' '*.tlz=01;31' '*.txz=01;31' '*.tzo=01;31' '*.t7z=01;31' '*.zip=01;31' '*.z=01;31' '*.Z=01;31' '*.dz=01;31' '*.gz=01;31' '*.lrz=01;31' '*.lz=01;31' '*.lzo=01;31' '*.xz=01;31' '*.zst=01;31' '*.tzst=01;31' '*.bz2=01;31' '*.bz=01;31' '*.tbz=01;31' '*.tbz2=01;31' '*.tz=01;31' '*.deb=01;31' '*.rpm=01;31' '*.jar=01;31' '*.war=01;31' '*.ear=01;31' '*.sar=01;31' '*.rar=01;31' '*.alz=01;31' '*.ace=01;31' '*.zoo=01;31' '*.cpio=01;31' '*.7z=01;31' '*.rz=01;31' '*.cab=01;31' '*.jpg=01;35' '*.jpeg=01;35' '*.mjpg=01;35' '*.mjpeg=01;35' '*.gif=01;35' '*.bmp=01;35' '*.pbm=01;35' '*.pgm=01;35' '*.ppm=01;35' '*.tga=01;35' '*.xbm=01;35' '*.xpm=01;35' '*.tif=01;35' '*.tiff=01;35' '*.png=01;35' '*.svg=01;35' '*.svgz=01;35' '*.mng=01;35' '*.pcx=01;35' '*.mov=01;35' '*.mpg=01;35' '*.mpeg=01;35' '*.m2v=01;35' '*.mkv=01;35' '*.webm=01;35' '*.ogm=01;35' '*.mp4=01;35' '*.m4v=01;35' '*.mp4v=01;35' '*.vob=01;35' '*.qt=01;35' '*.nuv=01;35' '*.wmv=01;35' '*.asf=01;35' '*.rm=01;35' '*.rmvb=01;35' '*.flc=01;35' '*.avi=01;35' '*.fli=01;35' '*.flv=01;35' '*.gl=01;35' '*.dl=01;35' '*.xcf=01;35' '*.xwd=01;35' '*.yuv=01;35' '*.cgm=01;35' '*.emf=01;35' '*.ogv=01;35' '*.ogx=01;35' '*.aac=00;36' '*.au=00;36' '*.flac=00;36' '*.m4a=00;36' '*.mid=00;36' '*.midi=00;36' '*.mka=00;36' '*.mp3=00;36' '*.mpc=00;36' '*.ogg=00;36' '*.ra=00;36' '*.wav=00;36' '*.oga=00;36' '*.opus=00;36' '*.spx=00;36' '*.xspf=00;36' list-colors ''

# Nicer format for completion messages
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'

# Show message while waiting for completion
zstyle ':completion:*' show-completer true

# Auto rehash
zstyle ':completion:*' rehash true

#
# :: PROMPT
#
setopt promptsubst
autoload -Uz colors && colors

function parse_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')
  FLAGS+='--ignore-submodules=dirty'
  if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
    FLAGS+='--untracked-files=no'
  fi
  STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then
    echo ") %{$fg[yellow]%}✗ "
  else
    echo ") %{$fg[green]%}✔ "
  fi
}

function git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "%{$fg[cyan]%}(${ref#refs/heads/}$(parse_git_dirty)%{$reset_color%}"
}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
local ret_cwd="%(?:%{$fg[blue]%}:%{$fg[red]%})%~"

PROMPT='%m:${ret_cwd} $(git_prompt_info)% %{$reset_color%}'


#
# :: HISTORY
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorespace
setopt histverify
setopt sharehistory
setopt incappendhistory

# Emacs key bindings
bindkey -e
# Map 'v' to edit-command-line in vicmd
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

#
# :: virtualenvwrapper
#
if [ -e /usr/bin/virtualenvwrapper_lazy.sh ]; then
  source /usr/bin/virtualenvwrapper_lazy.sh
elif [ -e /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh ]; then
  source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh
fi

#
# :: ponysay
#
if [ ! -z $DISPLAY ] && [ ! -z $TMUX ]; then
  if which ponysay > /dev/null; then
    ponysay -o
  fi
fi

#
# :: fzf
#
for f in /usr/share/fzf/key-bindings.zsh /usr/share/fzf/completion.zsh; do
  [ -f $f ] && source $f
done

export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
_gen_fzf_default_opts() {
  local color00='#282828'
  local color01='#3c3836'
  local color02='#504945'
  local color03='#665c54'
  local color04='#bdae93'
  local color05='#d5c4a1'
  local color06='#ebdbb2'
  local color07='#fbf1c7'
  local color08='#fb4934'
  local color09='#fe8019'
  local color0A='#fabd2f'
  local color0B='#b8bb26'
  local color0C='#8ec07c'
  local color0D='#83a598'
  local color0E='#d3869b'
  local color0F='#d65d0e'

  export FZF_DEFAULT_OPTS="
    --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
    --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
    --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
  "
}
_gen_fzf_default_opts

# ==> .zshrc.local
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

case $TERM in
  xterm*|rxvt*|st-*)
    precmd () {print -Pn "\e]0;zsh%L %(1j,%j job%(2j|s|); ,)%~\a" }
    preexec () {printf "\033]0;%s\a" "$1" }
    ;;
esac

if [ -z $TMUX ] && [ -n "$DISPLAY" ]; then
    (tmux ls | grep -vq attached && exec tmux -2 at) || exec tmux -2
fi
