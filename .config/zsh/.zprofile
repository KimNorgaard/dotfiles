# -U ensures each entry in these is unique (that is, discards duplicates).
export -U PATH path FPATH fpath MANPATH manpath
# -T creates a "tied" pair
export -UT INFOPATH infopath

path=(
  /opt/homebrew/bin(N)
  $path
  $GOPATH/bin(N)
  ~/.local/bin(N)
  ~/bin(N)
  ~/netic-bin(N)
  ~/.krew/bin(N)
)

fpath=(
  $fpath
  ~/.local/share/zsh/site-functions(N)
  /opt/homebrew/share/zsh/site-functions(N)
  /opt/homebrew/share/zsh-completions(N)
)

manpath=(
  $manpath
  /usr/share/man
  /opt/homebrew/share/man(N)
)

infopath=(
  $infopath
  /opt/homebrew/share/info(N)
)

