#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

rpm-ostree install -yA \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
	https://copr.fedorainfracloud.org/coprs/starfish/howdy-beta/repo/fedora-$(rpm -E %fedora)/starfish-howdy-beta-fedora-43.repo

# this installs a package from fedora repos
rpm-ostree install -yA \
	fish micro netcat fastfetch bsd-games rogue steam mpd \
	arp-scan evtest telnet adw-gtk3-theme input-remapper \
	waypipe nautilus-gsconnect ibm-plex-fonts-all steam-devices \
	gnome-software-rpm-ostree mozilla-openh264 howdy howdy-gtk

# Use a COPR Example:
# rpm-ostree -y copr enable starfish/howdy-beta
# dnf5 -y install
# dnf5 -y copr disable starfish/howdy-beta
# Disable COPRs so they don't end up enabled on the final image:

#### Example for enabling a System Unit File

#chmod 666 /dev/video2
systemctl enable podman.socket input-remapper mpd