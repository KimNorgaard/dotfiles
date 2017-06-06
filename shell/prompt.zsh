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
local ret_cwd="%(?:%{$fg[green]%}:%{$fg[red]%})%~"

#PROMPT='${ret_status} %{$fg_bold[blue]%}%c $(git_prompt_info)% %{$reset_color%}'
PROMPT='%m:${ret_cwd} $(git_prompt_info)% %{$reset_color%}'

