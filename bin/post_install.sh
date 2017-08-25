#!/bin/bash
#
# This script performs post installation tasks after a clean install
#

pac() {
  sudo pacman --noconfirm --noprogressbar --needed --quiet $*
  if [ $? -ne 0 ]; then
    err "Failed."
    exit 1
  fi
}

inst() {
  pac -S $*
}

aurinst() {
  pacaur --noconfirm --needed --noedit --silent -S $*
  if [ $? -ne 0 ]; then
    err "Failed."
    exit 1
  fi
}

h1() {
  echo
  echo -e "\e[96m**************************************************\e[0m"
  echo -e "\e[96m* $*\e[0m"
  echo -e "\e[96m**************************************************\e[0m"
}

h2() {
  echo -e "\e[32m*** $*\e[0m"
}

err() {
  echo -e "\e[91m*** $*\e[0m"
}

h1 "Checking stuff"

h2 "I am groot?"
id
if [ "$(id --user)" = "0" ]; then
  err "A am groot!"
  exit 1
fi

h2 "I haz sudo?"
which sudo
if [ $? -ne 0 ]; then
  err "Nope."
  exit 1
fi

h2 "I haz net?"
ping -c1 -w3 8.8.8.8

if [ $? -ne 0 ]; then
  echo "Failed."
  exit 1
fi

h1 "Running pacman -Syu"
pac -Syu --quiet

h1 "Installing packages"

h2 "Installing base utils"
inst ack acpi acpid cowsay ansible bc dialog docker efibootmgr efivar fzf git gnupg ipcalc jq kbd lastpass-cli lsof openssh parted ponysay puppet ranger smartmontools sshpass strace subversion sudo tmux tree unrar unzip xz zip

h2 "Installing net utils"
inst bind-tools curl ethtool gnu-netcat ifplugd iw net-snmp net-tools ntp openconnect openvpn rfkill rsync smbclient tcpdump traceroute vpnc w3m wget whois wpa_supplicant

h2 "Installing power management utils"
inst acpi_call powertop tlp tp_smapi

h2 "Installing sound stuff"
inst alsa-lib alsa-plugins alsa-utils pavucontrol pulseaudio pulseaudio-alsa

h2 "Installing bluetooth packages"
inst bluez bluez-libs bluez-utils pulseaudio-bluetooth

h2 "Installing printing utils"
inst a2ps cups cups-filters cups-pdf

h2 "Installing video drivers and utils"
inst libva-intel-driver libva-utils mesa vulkan-intel xf86-video-intel

h2 "Installing X and friends"
inst compton feh notify-osd scrot xautolock xclip xf86-input-synaptics xorg-apps xorg-server xorg-xinit xsel xterm

h2 "Installing window manager stuff"
inst i3-wm i3blocks i3lock rofi

h2 "Installing browsers"
inst firefox chromium flashplugin

h2 "Installing video things"
inst ffmpeg mencoder mplayer mpv smpeg

h2 "Installing pdf things"
inst mupdf qpdf xpdf zathura zathura-pdf-mupdf

h2 "Installing other X based stuff"
inst libreoffice-fresh freerdp recordmydesktop redshift

h2 "Installing editors"
inst neovim

h2 "Installing development languages"
inst go go-tools python python2 python-virtualenv ruby ruby-bundler jdk8-openjdk

h2 "Installing development libraries"
inst expat yajl python-gobject python-keyring python-pip python-requests-oauthlib python-xdg

h2 "Installing development tools"
inst elfutils flake8

h2 "Installing secrets stuff"
inst gnome-keyring libgnome-keyring seahorse

h2 "Installing mail stuff"
inst antiword isync msmtp mutt notmuch

h2 "Installing themes and icons"
inst arc-gtk-theme adwaita-icon-theme gnome-themes-standard

h2 "Installing fonts"
inst terminus-font ttf-dejavu ttf-hack ttf-inconsolata ttf-roboto

h1 "Installing pacaur"
mkdir -p /tmp/pacaur_install
(
  cd /tmp/pacaur_install
  if [ ! -n "$(pacman -Qs cower)" ]; then
    h1 "Installing cower dependency"
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
    makepkg PKGBUILD --force --skippgpcheck --install --needed --noconfirm
  fi

  if [ ! -n "$(pacman -Qs pacaur)" ]; then
    h1 "Building and installing"
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
    makepkg PKGBUILD --force --skippgpcheck --install --needed --noconfirm
  fi

  cd
  rm -rf /tmp/pacaur_install
)

h1 "Installing pacaur packages"

h2 "Development libraries"
aurinst ruby-neovim
aurinst ruby-msgpack

h2 "Fonts"
aurinst ttf-iosevka
aurinst ttf-ms-fonts
aurinst ttf-fira-code
aurinst otf-fira-code

h2 "Mail, calendar, contacts"
aurinst khard
aurinst vdirsyncer

h2 "Other tools"
aurinst todotxt
aurinst tty-clock-git
aurinst input-utils
aurinst gnome-keyring-query
aurinst kubectl-bin
aurinst razercfg

h2 "Big apps"
aurinst spotify
aurinst dropbox
aurinst hipchat
aurinst franz-bin

h2 "rxvt-unicode"
aurinst rxvt-unicode-cvs
inst "xrxvt-perls rxvt-unicode-terminfo"
aurinst urxvt-font-size-git


h1 "Setup services"

h2 "ntp"
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service

h2 "ssh"
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

h2 "bluetooth"
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

h2 "netctl-sleep"
sudo systemctl enable netctl-sleep.service

h2 "tlp"
sudo systemctl enable tlp.service
sudo systemctl start tlp.service

h2 "i3lock"
if [ ! -f /etc/systemd/system/i3lock.service ]; then
  sudo cp -v sysetcetc/systemd/system/i3lock.service /etc/systemd/system/
fi
sudo systemctl enable i3lock.service

h2 "getty@tty1"
if [ ! -d /etc/systemd/system/getty@tty1.service.d ]; then
  sudo cp -v -a sysetcetc/systemd/system/getty@tty1.service.d /etc/systemd/system/
fi


h1 "User access"

h2 "add $USER to docker group"
sudo usermod -a -G docker $USER

h2 "add $USER to lp group"
sudo usermod -a -G lp $USER

h2 "add $USER to input group"
sudo usermod -a -G input $USER

h2 "add $USER to audio group"
sudo usermod -a -G audio $USER

h2 "add $USER to video group"
sudo usermod -a -G video $USER


h1 "System configuration"

h2 "Scripts"
sudo cp -v -b --suffix=.bak -a bin/backlight.sh /etc/acpi/
sudo cp -v -b --suffix=.bak -a bin/powersave.sh /usr/local/bin/

h2 "sysctl.d"
sudo cp -v -b --suffix=.bak sysetcetc/sysctl.d/tuning.conf /etc/sysctl.d/

h2 "udev rules"
sudo cp -v -b --suffix=.bak sysetcetc/udev/rules.d/10-network.rules /etc/udev/rules.d/
sudo cp -v -b --suffix=.bak sysetcetc/udev/rules.d/20-powersave.rules /etc/udev/rules.d/
sudo cp -v -b --suffix=.bak sysetcetc/udev/rules.d/99-monitor-hotplug.rules /etc/udev/rules.d/

h1 "Xorg"
sudo cp -v -b --suffix=.bak sysetcetc/X11/xorg.conf.d/* /etc/X11/xorg.conf.d/

h1 "neovim"

(
cd

if [ ! -d ".python3_neovim" ]; then
  h2 "for python3"
  virtualenv .python3_neovim
  source .python3_neovim/bin/activate
  pip install neovim
  deactivate
fi

if [ ! -d ".python2_neovim" ]; then
  h2 "for python2"
  virtualenv -p /usr/bin/python2 .python2_neovim
  source .python2_neovim/bin/activate
  pip install neovim
  deactivate
fi
)
