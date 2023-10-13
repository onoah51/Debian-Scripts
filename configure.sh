#!/bin/sh
# Generic system configuration for Debian based workstations/servers

echo "This is a generic system configuration for Debian based workstations/servers"

# Function to upgrade system packages
upgrade_packages() {
    echo "Upgrading system packages..."
    sudo apt-get update -y && sudo apt upgrade -y
}

# Function to install required packages
install_packages() {
    echo "Installing required packages..."
    sudo apt-get install ufw curl git wget fail2ban openssh-server nano btop net-tools -y
}

# Function to make temp directory and clone GH repo
make_tempdir_and_clone() {
    echo "Cloning GitHub Repository..."
    mkdir -p ~/temp && git clone https://github.com/onoah51/Debian ~/temp/Debian
}

# Function to configure/secure SSH server
configure_ssh() {
    echo "Configuring the SSH Server daemon..."
    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
    sudo mv ~/temp/Debian/sshd_config /etc/ssh/sshd_config
    sudo systemctl enable sshd
    sudo systemctl restart sshd
}

# Function to configure UFW
configure_ufw() {
    echo "Configuring UFW..."
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
    echo "Configuring the Fail2Ban daemon..."
    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.conf.backup
    sudo mv ~/temp/Debian/jail.conf /etc/fail2ban/jail.conf
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

echo "Script is complete!"
