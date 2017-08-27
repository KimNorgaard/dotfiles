#-------------------------------------------------------------------------------
# PATH
#-------------------------------------------------------------------------------
typeset -U path

# Add paths if they exist and are not symlinks
for p in /bin /usr/bin /sbin /usr/sbin /usr/local/bin /usr/local/sbin $GOPATH/bin /usr/local/MacGPG2/bin ~/bin; do
  [ -e $p -a ! -L $p ] && path+=($p)
done

#-------------------------------------------------------------------------------
# .zprofile.local
#-------------------------------------------------------------------------------
[ -f ~/.zprofile.local ] && source ~/.zprofile.local
