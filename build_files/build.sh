#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

#rpm-ostree install -yA \
dnf5 -y install \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \

curl -L \
	https://copr.fedorainfracloud.org/coprs/starfish/howdy-beta/repo/fedora-$(rpm -E %fedora)/starfish-howdy-beta-fedora-43.repo \
	-o /etc/yum.repos.d/_copr_starfish-howdy-beta.repo
# this installs a package from fedora repos

#rpmfusion video drivers

dnf5 -y remove firefox
dnf5 -y swap mesa-va-drivers mesa-va-drivers-freeworld
dnf5 -y swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
dnf5 -y swap mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
dnf5 -y swap mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
dnf5 -y swap ffmpeg-free ffmpeg --allowerasing

#rpm-ostree install -yA \
dnf5 -y --refresh install --skip-unavailable \
	fish micro netcat fastfetch bsd-games rogue steam mpd \
	arp-scan evtest telnet adw-gtk3-theme input-remapper \
	waypipe nautilus-gsconnect ibm-plex-fonts-all steam-devices \
	gnome-software-rpm-ostree mozilla-openh264 howdy howdy-gtk \
	rpmfusion-free-release-tainted libdvdcss

# Use a COPR Example:
# rpm-ostree -y copr enable starfish/howdy-beta
# dnf5 -y install
# dnf5 -y copr disable starfish/howdy-beta
# Disable COPRs so they don't end up enabled on the final image:

#### Example for enabling a System Unit File

#chmod 666 /dev/video2
systemctl enable podman.socket input-remapper #mpd should be started by user