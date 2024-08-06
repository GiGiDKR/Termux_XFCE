#!/bin/zsh

username="$1"

pkgs=('git' 'neofetch' 'virglrenderer-android' 'papirus-icon-theme' 'xfce4' 'xfce4-goodies' 'eza' 'pavucontrol-qt' 'bat' 'jq' 'nala' 'wmctrl' 'firefox' 'netcat-openbsd' 'termux-x11-nightly' 'eza')

# Installer xfce4 desktop et les paquets supplémentaires
pkg install "${pkgs[@]}" -y -o Dpkg::Options::="--force-confold"

# Placer l'icône de Firefox sur le bureau
cp $PREFIX/share/applications/firefox.desktop $HOME/Desktop 
chmod +x $HOME/Desktop/firefox.desktop

# Définir les alias
echo "
alias l='eza -1 --icons'
alias ls='eza --icons'
alias ll='eza -lF -a  --icons --total-size  --no-permissions  --no-time --no-user'
alias la='eza --icons -lgha --group-directories-first'
alias lt='eza --icons --tree'
alias lta='eza --icons --tree -lgha'
alias dir='eza -lF --icons'
alias ..='cd ..'
alias q='exit'
alias c='clear'
alias md='mkdir'
alias debian='proot-distro login debian --user $username --shared-tmp'
#alias zrun='proot-distro login debian --user $username --shared-tmp -- env DISPLAY=:1.0 MESA_LOADER_DRIVER_OVERRIDE=zink TU_DEBUG=noconform '
#alias zrunhud='proot-distro login debian --user $username --shared-tmp -- env DISPLAY=:1.0 MESA_LOADER_DRIVER_OVERRIDE=zink TU_DEBUG=noconform GALLIUM_HUD=fps '
alias hud='GALLIUM_HUD=fps '
alias cat='bat '
alias apt='nala '
alias install='nala install -y '
alias uninstall='nala remove -y '
alias update='nala update'
alias upgrade='nala upgrade -y'
alias search='nala search '
alias list='nala list --upgradeable'
alias show='nala show'
" >> $PREFIX/etc/zshrc

# Télécharger le fond d'écran
wget https://raw.githubusercontent.com/GiGIDKR/Termux_XFCE/main/mac_waves.png
mv mac_waves.png $PREFIX/share/backgrounds/xfce/

# Installer le thème WhiteSur-Dark
wget https://github.com/vinceliuice/WhiteSur-gtk-theme/archive/refs/tags/2024-05-01.zip
unzip 2024-05-01.zip
tar -xf WhiteSur-gtk-theme-2024-05-01/release/WhiteSur-Dark.tar.xz
mv WhiteSur-Dark/ $PREFIX/share/themes/
rm -rf WhiteSur*
rm 2024-05-01.zip

# Installer le thème d'icônes Fluent Cursor
wget https://github.com/vinceliuice/Fluent-icon-theme/archive/refs/tags/2024-02-25.zip
unzip 2024-02-25.zip
mv Fluent-icon-theme-2024-02-25/cursors/dist $PREFIX/share/icons/ 
mv Fluent-icon-theme-2024-02-25/cursors/dist-dark $PREFIX/share/icons/
rm -rf $HOME/Fluent*
rm 2024-02-25.zip

# Installer les polices Meslo et NotoColorEmoji
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip
unzip Meslo.zip -d $HOME/.fonts/
rm Meslo.zip
rm $HOME/.fonts/LICENSE.txt
rm $HOME/.fonts/README.md

wget https://github.com/GiGIDKR/Termux_XFCE/raw/main/NotoColorEmoji-Regular.ttf
mv NotoColorEmoji-Regular.ttf $HOME/.fonts/

wget https://github.com/GiGIDKR/Termux_XFCE/raw/main/font.ttf
mv font.ttf $HOME/.termux/font.ttf

# Autostart Conky et Flameshot
wget https://github.com/GiGIDKR/Termux_XFCE/raw/main/config.tar.gz
tar -xvzf config.tar.gz
rm config.tar.gz
chmod +x $HOME/.config/autostart/conky.desktop
chmod +x $HOME/.config/autostart/org.flameshot.Flameshot.desktop