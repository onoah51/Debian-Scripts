# Debian System Configuration Script

This script offers a comprehensive system configuration for Debian-based workstations and servers, ensuring a secured and up-to-date setup.

## Features:

1. **Set up Debian Repositories:** Verifies and sets the correct Debian stable repositories.
2. **Upgrades System Packages:** Ensures your system packages are up-to-date.
3. **Installs Required Packages:** Provides an array of packages essential for server maintenance, such as ufw, curl, git, wget, fail2ban, openssh-server, nano, btop, net-tools, ntp, and systemd-timesyncd. 
4. **Timezone and NTP Configuration:** Changes system timezone and configures NTP
5. **Clones a GitHub Repository:** Creates a temporary directory and clones a designated repository.
6. **Configures SSH Server:** Includes functionality for integrity checks, backup of existing configurations, and applies new configurations.
7. **Configures UFW:** Sets up a secure firewall policy.
8. **Configures Fail2Ban:** Helps protect your server against malicious authentication attempts.
9. **Hostname Modification:** Option to change the system's hostname.
10. **DNS Configuration:** Allows changing the default DNS servers for better privacy and performance.

## Prequisites:

1. The script assumes that the user has appropriate 'sudo' privileges.
2. Make sure the script is executable with: chmod +x script_name.sh

## Logs:

The script logs all of its operations to '~/system_setup.log'. This can be useful for troubleshooting or future auditing.

## Information:

This script is a work in progress with script additions and changes coming in the future.

## Author:

Crafted by onoah51. Feedback, suggestions, or contributions are always appreciated!

## Usage:

To deploy the script, use the following command:

sudo ./configure.sh

Upon execution, the user will be prompted to confirm if they wish to proceed with the configuration.