# Debian System Configuration Script

This script provides a generic system configuration for Debian-based workstations and servers.

## Features:

1. **Upgrades System Packages:** Ensures your system packages are up-to-date.
2. **Installs Required Packages:** Provides an array of packages essential for server maintenance, such as `ufw`, `curl`, `git`, `wget`, `fail2ban`, `openssh-server`, `nano`, `btop`, and `net-tools`.
3. **Clones a GitHub Repository:** Creates a temporary directory and clones a designated repository.
4. **Configures SSH Server:** Includes functionality for integrity checks, backup of existing configurations, and applies new configurations.
5. **Configures UFW:** Sets up a secure firewall policy.
6. **Configures Fail2Ban:** Helps protect your server against malicious authentication attempts.

## Prequisites:

1. The script assumes that the user has appropriate 'sudo' privileges.
2. Make sure the script is executable with: chmod +x script_name.sh

## Logs:

The script logs all of its operations to '~/system_setup.log'. This can be useful for troubleshooting or future auditing changes.

## Author:

Written by onoah51. Contributions and feedback is welcome!

## Usage:

```sh
./script_name.sh

Upon execution, the user will be prompted to confirm if they wish to proceed with the configuration.