#!/bin/sh
# Generic system configuration for Debian based workstations/servers
# Version 1.0
# Written by onoah51

LOGFILE=~/system_setup.log

# Logging function
log() {
    echo "$1" | tee -a $LOGFILE
}

# Error check function
check_error() {
    if [ $? -ne 0 ]; then
        log "Error: $1"
        exit 1
    fi
}

echo "This is a generic system configuration for Debian based workstations/servers"
read -p "Do you want to proceed with the configuration (yes/no)? " confirmation

if [ "$confirmation" != "yes" ]; then
    echo "Aborting."
    exit 0
fi

# Function to upgrade system packages
upgrade_packages() {
    log "Upgrading system packages..."
    sudo apt-get update -y && sudo apt upgrade -y
    check_error "Failed upgrading packages."
}

# Function to install required packages
install_packages() {
    log "Installing required packages..."
    sudo apt-get install ufw curl git wget fail2ban openssh-server nano btop net-tools -y
    check_error "Failed installing packages."
}

# Function to make temp directory and clone GH repo
make_tempdir_and_clone() {
    log "Cloning GitHub Repository..."
    mkdir -p ~/temp && git clone https://github.com/onoah51/Debian ~/temp/Debian
    check_error "Failed cloning repository."
}

# Check if the file exists
check_file_exists() {
    if [ ! -f $1 ]; then
        log "Error: $1 does not exist."
        exit 1
    fi
}

# Assuming you want to verify the integrity using checksum
verify_checksum() {
    computed_checksum=$(sha256sum $1 | awk '{ print $1 }')
    provided_checksum=$(grep $(basename $1) ~/temp/Debian/checksum.txt | awk '{ print $2 }')

    if [ "$computed_checksum" != "$provided_checksum" ]; then
        log "Error: Checksum verification failed for $1"
        exit 1
    fi
}

# Function to configure/secure SSH server
configure_ssh() {
    log "Configuring the SSH Server daemon..."
    check_file_exists "~/temp/Debian/sshd_config"
    verify_checksum "~/temp/Debian/sshd_config"
    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
    check_error "Failed backing up SSH configuration."
    sudo mv ~/temp/Debian/sshd_config /etc/ssh/sshd_config
    check_error "Failed updating SSH configuration."
    sudo systemctl enable sshd
    sudo systemctl restart sshd
}

# Function to configure UFW
configure_ufw() {
    log "Configuring UFW..."
    sudo systemctl enable ufw
    sudo systemctl start ufw
    sudo ufw enable
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw reload
    sudo systemctl restart ufw
}

# Function to configure Fail2Ban
configure_fail2ban() {
    log "Configuring the Fail2Ban daemon..."
    check_file_exists "~/temp/Debian/jail.conf"
    verify_checksum "~/temp/Debian/jail.conf"
    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.conf.backup
    check_error "Failed backing up Fail2Ban configuration."
    sudo mv ~/temp/Debian/jail.conf /etc/fail2ban/jail.conf
    check_error "Failed updating Fail2Ban configuration."
    sudo systemctl enable fail2ban
    sudo systemctl restart fail2ban
}

# Run functions
upgrade_packages
install_packages
make_tempdir_and_clone
configure_ssh
configure_ufw
configure_fail2ban

log "Script is complete!"
