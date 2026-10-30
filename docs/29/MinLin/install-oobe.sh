#!/bin/bash

set -euo pipefail
umask 022

export PATH=/usr/sbin:/usr/bin:/sbin:/bin

readonly TARGET="/opt/minlin/oobe.sh"
readonly GETTY_DIR="/etc/systemd/system/getty@tty1.service.d"
readonly AUTOLOGIN_CONF="$GETTY_DIR/50-minlin-oobe.conf"

if (( EUID != 0 )); then
    printf 'This script must run as root.\n' >&2
    exit 1
fi

# Accept an optional source path, or use the adjacent oobe.sh.
SOURCE=${1:-"$(dirname -- "${BASH_SOURCE[0]}")/oobe.sh"}

if [[ ! -f "$SOURCE" ]]; then
    printf 'OOBE script not found: %s\n' "$SOURCE" >&2
    exit 1
fi

# Check syntax before changing the system.
bash -n -- "$SOURCE"

# Install the OOBE script with explicit ownership and permissions.
install -d -o root -g root -m 0755 /opt/minlin

if [[ ! "$SOURCE" -ef "$TARGET" ]]; then
    install -o root -g root -m 0755 -- "$SOURCE" "$TARGET"
else
    chown root:root "$TARGET"
    chmod 0755 "$TARGET"
fi

# Enable root autologin on the first virtual console.
install -d -o root -g root -m 0755 "$GETTY_DIR"

cat > "$AUTOLOGIN_CONF" <<'EOF'
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin root --noclear %I $TERM
EOF

chown root:root "$AUTOLOGIN_CONF"
chmod 0644 "$AUTOLOGIN_CONF"

# Use OOBE as the temporary root login shell.
# Keep the existing root password unchanged.
usermod --shell "$TARGET" root

systemctl daemon-reload

# Do not restart the getty that may own the current session.
printf '\nMinLin OOBE has been installed and enabled.\n'
printf 'The current session has not been restarted.\n'
printf 'Run "systemctl reboot" when ready to start OOBE.\n'
