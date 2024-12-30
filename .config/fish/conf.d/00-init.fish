set -x GOPATH ~/src/go

fish_add_path --prepend (path filter /opt/homebrew/bin)
fish_add_path --append --path (path filter $GOPATH/bin ~/.local/bin ~/bin ~/netic-bin ~/.krew/bin)

