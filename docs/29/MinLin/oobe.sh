#!/bin/bash

set +x
set -Eeuo pipefail
umask 077
ulimit -c 0

export PATH=/usr/sbin:/usr/bin:/sbin:/bin
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

unset LANGUAGE DIALOGOPTS DIALOGRC
unset PASSWORD CONFIRM_PASSWORD

readonly TITLE="MinLin Out-of-Box Experience"
readonly MAIN_PID=$BASHPID
readonly GETTY_DIR="/etc/systemd/system/getty@tty1.service.d"
readonly AUTOLOGIN_CONF="$GETTY_DIR/50-minlin-oobe.conf"
readonly SUDO_CONF="/etc/sudoers.d/90-minlin-admin"
readonly RANDOM_SEED_TOOL="/usr/lib/systemd/systemd-random-seed"

HOST_NAME=""
FULL_NAME=""
USER_NAME=""
PASSWORD=""
CONFIRM_PASSWORD=""
FORM_ERROR=""

RUNTIME_DIR=""
DIALOG_RC=""
XRDP_CERT=""
XRDP_KEY=""
STAGE="Checking the environment"
COMMIT_STARTED=0


# Remove only temporary files created by this program.
cleanup() {
    if (( BASHPID != MAIN_PID )); then
        return 0
    fi

    unset PASSWORD CONFIRM_PASSWORD

    if [[ -n "$DIALOG_RC" ]]; then
        rm -f -- "$DIALOG_RC" || :
    fi

    if [[ -n "$RUNTIME_DIR" ]]; then
        rmdir -- "$RUNTIME_DIR" 2>/dev/null || :
    fi
}


# Report errors without printing commands or password values.
fail() {
    local message=$1
    local status=${2:-1}
    local text

    text=$'MinLin setup could not finish.\n\n'
    text+="$message"
    text+=$'\n\nStage: '
    text+="$STAGE"

    if (( COMMIT_STARTED )); then
        text+=$'\n\nSome settings may already have been applied.'
        text+=$'\nUse another console to inspect the system.'
    fi

    if [[ -t 0 && -t 2 ]] &&
        command -v dialog >/dev/null 2>&1; then
        DIALOGRC=/dev/null dialog \
            --title "$TITLE" \
            --clear \
            --msgbox "$text" 18 76 || :
    fi

    printf '\n%s\n' "$text" >&2
    exit "$status"
}


on_error() {
    local status=$1
    local line=$2

    trap - ERR

    # Let the main process report command substitution failures.
    if (( BASHPID != MAIN_PID )); then
        exit "$status"
    fi

    fail "A command failed at line $line (status $status)." "$status"
}


trap cleanup EXIT
trap 'on_error "$?" "$LINENO"' ERR
trap 'exit 1' HUP INT QUIT TERM

# This program may be running as the root login shell.
trap '' TSTP


ui() {
    dialog --title "$TITLE" "$@"
}


# Customize form navigation without changing system-wide settings.
prepare_dialog() {
    RUNTIME_DIR=$(mktemp -d /run/minlin-oobe.XXXXXX)
    DIALOG_RC="$RUNTIME_DIR/dialogrc"

    cat > "$DIALOG_RC" <<'EOF'
bindkey formfield TAB form_next
bindkey formfield BTAB form_prev
EOF

    export DIALOGRC="$DIALOG_RC"
}


# Read a setting from the Globals section of xrdp.ini.
read_xrdp_setting() {
    local setting=$1

    awk -v wanted="$setting" '
        /^[[:space:]]*[#;]/ { next }
        {
            line = $0
            sub(/^[[:space:]]+/, "", line)
            sub(/[[:space:]]+$/, "", line)
        }
        line ~ /^\[/ {
            in_globals = (tolower(line) == "[globals]")
            next
        }
        in_globals && index(line, "=") {
            pos = index(line, "=")
            key = substr(line, 1, pos - 1)
            value = substr(line, pos + 1)
            sub(/[[:space:]]+$/, "", key)
            sub(/^[[:space:]]+/, "", value)
            if (tolower(key) == wanted) {
                result = value
            }
        }
        END { print result }
    ' /etc/xrdp/xrdp.ini
}


check_ssh_configuration() {
    local configuration key value rest

    # sshd needs this runtime directory even for configuration tests.
    install -d -o root -g root -m 0755 /run/sshd

    configuration=$(/usr/sbin/sshd -T)

    while read -r key value rest; do
        case "$key" in
            hostkey)
                case "$value" in
                    /etc/ssh/ssh_host_rsa_key)
                        ;;
                    /etc/ssh/ssh_host_ecdsa_key)
                        ;;
                    /etc/ssh/ssh_host_ed25519_key)
                        ;;
                    *)
                        fail "A custom SSH HostKey path is configured."
                        ;;
                esac
                ;;
            hostcertificate)
                if [[ "$value" != "none" ]]; then
                    fail "SSH host certificates require manual handling."
                fi
                ;;
        esac
    done <<< "$configuration"
}


check_xrdp_configuration() {
    local cert_target key_target

    if [[ ! -f /etc/xrdp/xrdp.ini ]]; then
        fail "The XRDP configuration file is missing."
    fi

    XRDP_CERT=$(read_xrdp_setting certificate)
    XRDP_KEY=$(read_xrdp_setting key_file)

    XRDP_CERT=${XRDP_CERT:-/etc/xrdp/cert.pem}
    XRDP_KEY=${XRDP_KEY:-/etc/xrdp/key.pem}

    cert_target=$(readlink -m -- "$XRDP_CERT")
    key_target=$(readlink -m -- "$XRDP_KEY")

    if [[ "$cert_target" != \
        "/etc/ssl/certs/ssl-cert-snakeoil.pem" ]]; then
        fail "XRDP is not using the default snakeoil certificate."
    fi

    if [[ "$key_target" != \
        "/etc/ssl/private/ssl-cert-snakeoil.key" ]]; then
        fail "XRDP is not using the default snakeoil private key."
    fi
}


check_environment() {
    local command_name terminal unit state
    local -a commands=(
        dialog dpkg-reconfigure update-locale locale
        hostname getent useradd usermod chpasswd passwd
        sudo visudo runuser systemctl systemd-id128
        ssh-keygen sshd make-ssl-cert
        mountpoint readlink awk grep sed dd
        mktemp install chmod chown rm rmdir ln tty sleep
    )

    if (( EUID != 0 )); then
        fail "This program must run as root."
    fi

    if [[ ! -t 0 || ! -t 2 ]]; then
        fail "An interactive console is required."
    fi

    for command_name in "${commands[@]}"; do
        if ! command -v "$command_name" >/dev/null 2>&1; then
            fail "A required command is missing: $command_name"
        fi
    done

    terminal=$(tty)

    if [[ ! "$terminal" =~ ^/dev/tty[0-9]+$ ]]; then
        fail "Run OOBE from a local virtual console, not SSH or XRDP."
    fi

    if [[ ! -f "$AUTOLOGIN_CONF" ]]; then
        fail "MinLin first-use mode is not enabled."
    fi

    if [[ ! -x "$RANDOM_SEED_TOOL" ]]; then
        fail "The systemd random seed helper is missing."
    fi

    if ! locale -a |
        grep -Ei '^en_US\.(utf8|UTF-8)$' >/dev/null; then
        fail "Generate the en_US.UTF-8 locale in the image first."
    fi

    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8

    if [[ ! -f /etc/machine-id || -L /etc/machine-id ]]; then
        fail "/etc/machine-id must be a regular file."
    fi

    if mountpoint -q /etc/machine-id; then
        fail "/etc/machine-id is a mount point; resolve this first."
    fi

    if [[ -d /var/lib/dbus/machine-id ]]; then
        fail "/var/lib/dbus/machine-id must not be a directory."
    fi

    if ! getent group sudo >/dev/null; then
        fail "The sudo group is missing."
    fi

    if ! getent group ssl-cert >/dev/null; then
        fail "The ssl-cert group is missing."
    fi

    if ! getent passwd xrdp >/dev/null; then
        fail "The xrdp service account is missing."
    fi

    for unit in ssh.service xrdp.service; do
        state=$(systemctl show --property=LoadState --value "$unit")

        if [[ "$state" != "loaded" ]]; then
            fail "A required service is not available: $unit"
        fi
    done

    visudo --check

    check_ssh_configuration
    check_xrdp_configuration
}


# Page 1: Welcome.
welcome_page() {
    local text

    text=$'Welcome to MinLin\n\n'
    text+="Set your time zone, host name, and administrator account."
    text+=$'\n\nThis also replaces the machine identity and server keys.'
    text+=$'\nA reboot is required when setup finishes.'
    text+=$'\n\nThe time zone selection takes effect immediately.'

    ui --clear \
        --ok-label "Continue" \
        --msgbox "$text" 15 76 || exit 1
}


# Page 2: Time Zone.
timezone_page() {
    STAGE="Setting the time zone"

    # Keep the existing selection instead of resetting it to UTC.
    dpkg-reconfigure --frontend=dialog tzdata
}


validate_account_form() {
    local LC_ALL=C
    local host_pattern
    local user_pattern='^[a-z][a-z0-9_-]{0,31}$'

    host_pattern='^[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?$'
    FORM_ERROR=""

    if [[ ! "$HOST_NAME" =~ $host_pattern ]]; then
        FORM_ERROR="Host Name: use 1-63 letters, digits, or hyphens."
        FORM_ERROR+=" Start and end with a letter or digit."
        return 1
    fi

    if [[ -z "$FULL_NAME" ||
        "$FULL_NAME" == *[:,]* ||
        "$FULL_NAME" == *[[:cntrl:]]* ]]; then
        FORM_ERROR="Full Name: enter a name without colons, commas,"
        FORM_ERROR+=" or control characters."
        return 1
    fi

    if [[ ! "$USER_NAME" =~ $user_pattern ]]; then
        FORM_ERROR="User Name: start with a lowercase letter."
        FORM_ERROR+=" Use 1-32 lowercase letters, digits, underscores,"
        FORM_ERROR+=" or hyphens."
        return 1
    fi

    if getent passwd "$USER_NAME" >/dev/null ||
        getent group "$USER_NAME" >/dev/null; then
        FORM_ERROR="That user name is already in use."
        return 1
    fi

    if [[ -e "/home/$USER_NAME" || -L "/home/$USER_NAME" ]]; then
        FORM_ERROR="A home directory already exists for that user name."
        return 1
    fi

    if [[ -z "$PASSWORD" || "$PASSWORD" == *[[:cntrl:]]* ]]; then
        FORM_ERROR="Password must not be empty or contain"
        FORM_ERROR+=" control characters."
        return 1
    fi

    if [[ "$PASSWORD" != "$CONFIRM_PASSWORD" ]]; then
        FORM_ERROR="The passwords do not match."
        return 1
    fi

    return 0
}


# Page 3: Machine & User.
machine_user_page() {
    local reply prompt
    local -a fields

    STAGE="Entering the machine and account settings"

    while :; do
        prompt=$'Create your administrator account.\n'
        prompt+=$'Tab/Shift+Tab: fields   Enter: continue   Esc: cancel'
        prompt+=$'\n\nContinue applies the configuration.'

        if [[ -n "$FORM_ERROR" ]]; then
            prompt+=$'\n\n'"$FORM_ERROR"
        fi

        # Password fields always start empty.
        # No password is passed to dialog as a command argument.
        if ! reply=$(
            ui --clear \
                --stdout \
                --insecure \
                --ok-label "Continue" \
                --cancel-label "Cancel" \
                --mixedform "$prompt" 22 76 5 \
                "Host Name"        1 1 "$HOST_NAME" 1 21 44 63  0 \
                "Full Name"        2 1 "$FULL_NAME" 2 21 44 128 0 \
                "User Name"        3 1 "$USER_NAME" 3 21 44 32  0 \
                "Password"         4 1 ""          4 21 44 256 1 \
                "Confirm Password" 5 1 ""          5 21 44 256 1
        ); then
            exit 1
        fi

        mapfile -t fields < <(printf '%s\n' "$reply")

        HOST_NAME=${fields[0]-}
        FULL_NAME=${fields[1]-}
        USER_NAME=${fields[2]-}
        PASSWORD=${fields[3]-}
        CONFIRM_PASSWORD=${fields[4]-}

        unset reply fields

        if validate_account_form; then
            return 0
        fi

        PASSWORD=""
        CONFIRM_PASSWORD=""
    done
}


show_status() {
    local text

    STAGE=$1
    text=$'Configuring MinLin\n\n'
    text+="$STAGE"

    ui --infobox "$text" 8 76
}


configure_hostname() {
    # Preserve the spelling and case entered by the user.
    printf '%s\n' "$HOST_NAME" > /etc/hostname
    hostname "$HOST_NAME"

    sed -i '/^[[:space:]]*127\.0\.1\.1[[:space:]]/d' /etc/hosts
    printf '127.0.1.1\t%s\n' "$HOST_NAME" >> /etc/hosts
}


configure_locale() {
    # The locale itself was generated while preparing the image.
    update-locale --reset LANG=en_US.UTF-8
}


configure_user() {
    local rules rule_pattern sudo_uid

    useradd \
        --create-home \
        --home-dir "/home/$USER_NAME" \
        --user-group \
        --shell /bin/bash \
        --groups sudo \
        --comment "$FULL_NAME" \
        "$USER_NAME"

    # The shell builtin writes the password directly into a pipe.
    printf '%s:%s\n' "$USER_NAME" "$PASSWORD" | chpasswd

    install -d -o root -g root -m 0755 /etc/sudoers.d

    printf '%%sudo ALL=(ALL:ALL) PASSWD: ALL\n' > "$SUDO_CONF"
    chown root:root "$SUDO_CONF"
    chmod 0440 "$SUDO_CONF"

    visudo --check

    rules=$(LC_ALL=C sudo -l -U "$USER_NAME")

    rule_pattern='^[[:space:]]*\(ALL[[:space:]]*:[[:space:]]*ALL\)'
    rule_pattern+='[[:space:]]+(PASSWD:[[:space:]]*)?ALL[[:space:]]*$'

    if ! printf '%s\n' "$rules" |
        grep -E "$rule_pattern" >/dev/null; then
        fail "The new user does not have the required sudo grant."
    fi

    if printf '%s\n' "$rules" |
        grep -F 'NOPASSWD:' >/dev/null; then
        fail "The new user has an unexpected NOPASSWD sudo rule."
    fi

    # Check that sudo cannot run the test command without a password.
    if runuser -u "$USER_NAME" -- \
        sudo -k -n -u root -- /usr/bin/id -u \
        >/dev/null 2>&1
    then
        fail "The new user can run sudo without a password."
    fi

    # Authenticate with the new user's password and verify root access.
    sudo_uid=$(
        printf '%s\n' "$PASSWORD" |
            runuser -u "$USER_NAME" -- \
                sudo -k -S -p '' -u root -- /usr/bin/id -u
    )

    if [[ "$sudo_uid" != "0" ]]; then
        fail "The new user's sudo authentication test failed."
    fi

    runuser -u "$USER_NAME" -- sudo -K

    unset PASSWORD CONFIRM_PASSWORD
}


stop_remote_services() {
    # Stop socket activation before stopping the SSH service.
    if systemctl cat ssh.socket >/dev/null 2>&1; then
        systemctl stop ssh.socket
    fi

    systemctl stop ssh.service xrdp.service

    if systemctl cat xrdp-sesman.service >/dev/null 2>&1; then
        systemctl stop xrdp-sesman.service
    fi

    # Services will use their existing enablement state after reboot.
}


configure_ssh_host_keys() {
    # Remove old default host keys before generating replacements.
    rm -f -- \
        /etc/ssh/ssh_host_*_key \
        /etc/ssh/ssh_host_*_key.pub

    ssh-keygen -A

    # Stopping ssh.service may remove its runtime directory.
    install -d -o root -g root -m 0755 /run/sshd
    /usr/sbin/sshd -t
}


configure_xrdp_certificate() {
    /usr/sbin/make-ssl-cert \
        generate-default-snakeoil \
        --force-overwrite

    usermod --append --groups ssl-cert xrdp

    # Verify access using the service account's current groups.
    runuser -u xrdp -- /usr/bin/test -r "$XRDP_CERT"
    runuser -u xrdp -- /usr/bin/test -r "$XRDP_KEY"

    if [[ ! -s "$XRDP_CERT" || ! -s "$XRDP_KEY" ]]; then
        fail "The XRDP certificate or private key is empty."
    fi
}


configure_machine_id() {
    local new_id

    # Generate a fresh ID instead of reusing D-Bus or VM identifiers.
    new_id=$(systemd-id128 new)

    if [[ ! "$new_id" =~ ^[0-9a-f]{32}$ ||
        "$new_id" == "00000000000000000000000000000000" ]]; then
        fail "A valid new machine-id could not be generated."
    fi

    printf '%s\n' "$new_id" > /etc/machine-id
    chown root:root /etc/machine-id
    chmod 0444 /etc/machine-id

    install -d -o root -g root -m 0755 /var/lib/dbus
    ln -sfnT /etc/machine-id /var/lib/dbus/machine-id

    # Running services will fully adopt the new ID after reboot.
}


configure_random_seed() {
    # Save fresh kernel randomness without loading the old seed again.
    rm -f -- /var/lib/systemd/random-seed
    "$RANDOM_SEED_TOOL" save

    if [[ ! -s /var/lib/systemd/random-seed ]]; then
        fail "The new random seed was not saved."
    fi

    chown root:root /var/lib/systemd/random-seed
    chmod 0600 /var/lib/systemd/random-seed
}


finalize_oobe() {
    # Disable automatic OOBE before restoring the normal root shell.
    rm -- "$AUTOLOGIN_CONF"
    systemctl daemon-reload
    usermod --shell /bin/bash root

    # Lock root only after every required configuration step succeeds.
    passwd --lock root
}


# Page 4: Configuring.
configuring_page() {
    COMMIT_STARTED=1

    # Avoid interactive interruption during system modifications.
    trap '' INT QUIT TSTP

    show_status "Setting the host name..."
    configure_hostname

    show_status "Setting the default locale..."
    configure_locale

    show_status "Creating and testing the administrator account..."
    configure_user

    show_status "Waiting for the kernel random number generator..."

    # On Debian 13, this waits until the kernel RNG is initialized.
    dd if=/dev/random of=/dev/null \
        bs=32 count=1 iflag=fullblock status=none

    show_status "Stopping remote access services..."
    stop_remote_services

    show_status "Generating new SSH host keys..."
    configure_ssh_host_keys

    show_status "Generating the remote desktop certificate..."
    configure_xrdp_certificate

    show_status "Generating a new machine identity..."
    configure_machine_id

    show_status "Saving a new random seed..."
    configure_random_seed

    show_status "Finishing setup and locking the root password..."
    finalize_oobe
}


# Page 5: Finish.
finish_page() {
    local text

    STAGE="Waiting for reboot confirmation"

    text=$'MinLin is ready to use.\n\n'
    text+="Administrator: $USER_NAME"
    text+=$'\nHost name: '
    text+="$HOST_NAME"
    text+=$'\n\nThe root password is now locked.'
    text+=$'\nUse your new account and sudo for administration.'
    text+=$'\n\nSelect Reboot to finish applying the new identity.'

    # Setup is already committed, so cancellation cannot restart it.
    until ui --clear \
        --ok-label "Reboot" \
        --msgbox "$text" 16 76
    do
        sleep 0.2
    done
}


reboot_system() {
    STAGE="Rebooting"

    # Do not restart the getty that owns the current session.
    systemctl reboot
    exit 0
}


main() {
    check_environment
    prepare_dialog

    welcome_page
    timezone_page
    machine_user_page
    configuring_page
    finish_page

    reboot_system
}

main "$@"
