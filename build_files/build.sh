#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y --skip-unavailable fish micro netcat fastfetch bsd-games rogue arp-scan evtest \
		cargo gcc telnet adw-gtk3-theme input-remapper steam  \
		waypipe nautilus-gsconnect python3-oracledb

# Use a COPR Example:
#
dnf5 -y copr enable starfish/howdy-beta
dnf5 -y install howdy howdy-gtk
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable starfish/howdy-beta

#### Example for enabling a System Unit File

#chmod 666 /dev/video2
systemctl enable podman.socket


# Download the script
wget https://raw.githubusercontent.com/LuanAdemi/mediatek7925e-bluetooth-fix/refs/heads/main/mediatek_fix.sh

# Make it executable
chmod +x mediatek_fix.sh

# Run it with sudo
./mediatek_fix.sh --apply

rm ./mediatek_fix.sh