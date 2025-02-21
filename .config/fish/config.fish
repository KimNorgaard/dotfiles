if not status is-interactive
    return 0
end

set fish_greeting

# Set editor variables.
set -x PAGER less
set -x VISUAL nvim
set -x EDITOR nvim
set -x MANPAGER 'nvim +Man!'
set -x LESS "-RM"
set -x LESS_TERMCAP_mb (set_color -o ff0000) # begin blinking
set -x LESS_TERMCAP_md (set_color -o 5FAFD7) # begin bold
set -x LESS_TERMCAP_me (set_color normal)    # end mode
set -x LESS_TERMCAP_se (set_color normal)    # end standout-mode
set -x LESS_TERMCAP_so (set_color 949494)    # begin standout-mode - info box
set -x LESS_TERMCAP_us (set_color -u afafd7) # begin underline
set -x LESS_TERMCAP_ue (set_color normal)    # end underline

# Set browser on macOS.
switch (uname -s)
case Darwin
    set -x BROWSER open
case Linux
    set -x BROWSER xdg-open
end

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

  set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
  set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
  set -x FZF_ALT_C_COMMAND "fd -t d --hidden --strip-cwd-prefix --exclude .git"
  set -x FZF_CTRL_T_OPTS "--walker-skip .git"
  set -x FZF_ALT_C_OPTS "--walker-skip .git"
  set -x FZF_CTRL_R_OPTS "--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
end

if not set -q HOMEBREW_PREFIX
  if test -e /opt/homebrew/bin/brew
      /opt/homebrew/bin/brew shellenv | source
  else
      return 1
  end
end

set -q XDG_CONFIG_HOME || set -x XDG_CONFIG_HOME ~/.config
set -p MANPATH (path filter /opt/homebrew/share/man)
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_ENV_HINTS 1
if test -e "$HOMEBREW_PREFIX/share/fish/completions"
  set -a fish_complete_path "$HOMEBREW_PREFIX/share/fish/completions"
end

set -x LPASS_AGENT_TIMEOUT 28800
set -x PYLINTRC $XDG_CONFIG_HOME/pylint/pylintrc
set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/pystartup
set -x NOTMUCH_CONFIG $XDG_CONFIG_HOME/notmuch/config

if test -f ~/.config/fish/local.fish
  source ~/.config/fish/local.fish
end
