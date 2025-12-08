#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install -yA fish micro netcat fastfetch bsd-games rogue \
		arp-scan evtest telnet adw-gtk3-theme input-remapper steam  \
		waypipe nautilus-gsconnect ibm-plex-fonts-all \
		gnome-software-rpm-ostree mozilla-openh264

# Use a COPR Example:
#
rpm-ostree install -yA --rpm-repo=https://copr.fedorainfracloud.org/coprs/starfish/howdy-beta/ howdy howdy-gtk
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable starfish/howdy-beta

#### Example for enabling a System Unit File

#chmod 666 /dev/video2
systemctl enable podman.socket input-remapper

rpm-ostree override remove 'dnf*' 'libdnf*' python3-dnf python3-dnf5