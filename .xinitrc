xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
#xrandr --dpi 168 &
xrandr --dpi 144 &

xset r rate 250 25 &

xset -b &

. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

export TERMINAL=urxvtc
urxvtd &

xsetroot -solid "#333333" &
feh --bg-scale ~/Pictures/wallpapers/wallhaven-107269.jpg &

# redshift
/usr/bin/redshift-gtk &

xautolock -detectsleep \
          -corners -000 \
          -notify 120 -notifier "xset dpms force off" \
          -time 3 -locker "~/bin/lock.sh" \
          -killtime 60 -killer "systemctl suspend" &

exec i3
