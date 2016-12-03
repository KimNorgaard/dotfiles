eval $(ssh-agent)

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
xrandr --dpi 220

. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
#export SSH_AUTH_SOCK

feh --bg-scale ~/Pictures/wallpapers/NQp8ofd.jpg

xautolock -detectsleep \
          -notify 120 -notifier "xset dpms force off" \
          -time 3 -locker "i3lock -i /home/kn/lockscreen.png" \
          -killtime 60 -killer "systemctl suspend" &

exec i3
