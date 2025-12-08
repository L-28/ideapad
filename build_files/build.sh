#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

sudo rpm-ostree install \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# this installs a package from fedora repos
dnf5 install -y fish micro netcat fastfetch bsd-games rogue \
		arp-scan evtest telnet adw-gtk3-theme input-remapper \
		waypipe nautilus-gsconnect ibm-plex-fonts-all \
		gnome-software-rpm-ostree mozilla-openh264 steam-devices \
		steam mpd

# Use a COPR Example:
dnf5 -y copr enable starfish/howdy-beta
dnf5 -y install howdy howdy-gtk
dnf5 -y copr disable starfish/howdy-beta
# Disable COPRs so they don't end up enabled on the final image:

#### Example for enabling a System Unit File

#chmod 666 /dev/video2
systemctl enable podman.socket input-remapper mpd