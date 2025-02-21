if not status is-interactive
    return 0
end

set fish_greeting

set -q XDG_CONFIG_HOME || set -x XDG_CONFIG_HOME ~/.config
source $XDG_CONFIG_HOME/shell/env

fish_vi_key_bindings
set fish_cursor_insert block blink

abbr -a gaa git add --all
abbr -a gp git push
abbr -a gpl git pull
abbr -a gc git commit -asm
abbr -a gpb "git branch -vv | grep 'gone]' | awk '{print \$1}' | xargs git branch -D"
abbr -a --set-cursor='%' -- gcm 'git commit -m "%"'
abbr -a gsw git switch
abbr -a gst git status -s
abbr -a g git
abbr -a k kubectl
abbr -a lg lazygit
abbr -a tf terraform
abbr -a vi nvim
abbr -a vim nvim
abbr -a vimdiff nvim -d
abbr -a brwe brew
abbr vi nvim
abbr vim nvim
abbr ovi /usr/bin/vi
abbr ovim /usr/bin/vim
abbr d cdh
abbr -a ll ls -lFh
abbr -a lla ls -lFhA
abbr -a llrt ls -lFhArt


set -q MANPATH; or set -gx MANPATH ''

if type -q fzf
  if not test -r $__fish_cache_dir/fzf_init.fish
      fzf --fish >$__fish_cache_dir/fzf_init.fish
  end
  source $__fish_cache_dir/fzf_init.fish
end

if not set -q HOMEBREW_PREFIX
  if test -e /opt/homebrew/bin/brew
      /opt/homebrew/bin/brew shellenv | source
  else
      return 1
  end
end

set -p MANPATH (path filter /opt/homebrew/share/man)
if test -e "$HOMEBREW_PREFIX/share/fish/completions"
  set -a fish_complete_path "$HOMEBREW_PREFIX/share/fish/completions"
end

if test -f ~/.env.local
  source ~/.env.local
end
