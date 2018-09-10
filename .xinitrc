xrdb -merge ~/.Xresources
hotplug_display.sh
xsetroot -solid "#333333"

xrandr --dpi 144

. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# force XFT
export GDK_USE_XFT=1
export QT_XFT=true

export _JAVA_AWT_WM_NONREPARENTING="1"
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'


#rm -f ~/.local/share/clipster/clipster.pid
#clipster -d &

clipmenud &

dwmstatus &

redshift &

# compton --config ~/.config/compton.conf &

xautolock -detectsleep \
          -corners -000 \
          -notify 120 -notifier "xset dpms force off" \
          -time 5 -locker "~/bin/lockscreen" \
          -killtime 60 -killer "systemctl suspend" &

st -e mutt &
firefox &

exec dwm
