#!/bin/bash

set -euo pipefail

export PATH=/usr/sbin:/usr/bin:/sbin:/bin

readonly TARGET="/opt/minlin/oobe.sh"
readonly GETTY_DIR="/etc/systemd/system/getty@tty1.service.d"
readonly AUTOLOGIN_CONF="$GETTY_DIR/50-minlin-oobe.conf"

if (( EUID != 0 )); then
    printf 'This script must run as root.\n' >&2
    exit 1
fi

# Remove only the autologin configuration installed by MinLin.
rm -f -- "$AUTOLOGIN_CONF"

# Restore a usable root shell before removing the OOBE script.
usermod --shell /bin/bash root

# Leave other MinLin tools and configuration files untouched.
rm -f -- "$TARGET"

# Do not manage services from here, so this also works in a chroot.
printf '\nMinLin OOBE has been uninstalled.\n'
printf 'The root login shell is now /bin/bash.\n'
printf 'Passwords and existing system settings were not changed.\n'
printf '\nIf root is locked and no administrator is available,\n'
printf 'run "passwd root" to set a usable root password.\n'
printf '\nReboot the target system when repairs are complete.\n'
