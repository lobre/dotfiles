#/bin/sh
#
# should be run as user (with sudo capabilities)

set -e

# Install dotfiles
if [ ! -d "$HOME/Lab/dotfiles" ]; then
    git clone https://github.com/loric-/dotfiles.git $HOME/Lab/dotfiles
fi
(cd $HOME/Lab/dotfiles && python3 link.py)

# Set double click in file explorer
gsettings set io.elementary.files.preferences single-click false

# Apply colors
xrdb $HOME/.Xresources

# Fix gdm to load Xresources
sudo sed -i 's/xrdb -nocpp -merge "$userresources"/xrdb -merge "$userresources"/' /etc/gdm3/Xsession
