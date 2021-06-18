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

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_AUTO_SCREEN_SCALE_FACTOR=1


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

xset dpms 180 180 180

xautolock -detectsleep \
          -corners -000 \
          -notify 120 -notifier "xset dpms force off" \
          -time 5 -locker "~/bin/lockscreen" \
          -killtime 60 -killer "systemctl suspend" &

alacritty --title mutt -e mutt &
firefox &

exec dwm
