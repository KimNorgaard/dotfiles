#-------------------------------------------------------------------------------
# PATH
#-------------------------------------------------------------------------------
[[ ":$PATH:" != *":/bin:"* && ! -L /bin ]] && PATH=$PATH:/bin
[[ ":$PATH:" != *":/usr/bin:"* && ! -L /usr/bin ]] && PATH=$PATH:/usr/bin
[[ ":$PATH:" != *":/sbin:"* && ! -L /sbin ]] && PATH=$PATH:/sbin
[[ ":$PATH:" != *":/usr/sbin:"* && ! -L /usr/sbin ]] && PATH=$PATH:/usr/sbin
[[ ":$PATH:" != *":/usr/local/bin:"* ]] && PATH=$PATH:/usr/local/bin

[ -d $GOPATH/bin ] && PATH=$PATH:$GOPATH/bin

PATH=$PATH:~/bin

[ -d /usr/local/MacGPG2/bin ] && PATH=$PATH:/usr/local/MacGPG2/bin

#-------------------------------------------------------------------------------
# .zprofile.local
#-------------------------------------------------------------------------------
[ -f ~/.zprofile.local ] && source ~/.zprofile.local
