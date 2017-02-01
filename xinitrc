xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
xrandr --dpi 220

. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

#feh --bg-scale ~/Pictures/wallpapers/NQp8ofd.jpg
xsetroot -solid "#333333"

xautolock -detectsleep \
          -notify 120 -notifier "xset dpms force off" \
          -time 3 -locker "~/bin/lock.sh" \
          -killtime 60 -killer "systemctl suspend" &

exec i3
