#!/bin/bash
set -e

if [ "$DISABLE_ROOT_LOGIN" = "true" ]; then
    echo "Waiting for sshd to come up..."

    # Wait until sshd is listening on port 22
    while ! ss -lnt | grep -q ":22 "; do
        sleep 1
    done

    echo "Disabling root login..."

    # Disable root password login in sshd
    sed -i 's/^PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
    sed -i 's/^PermitRootLogin yes/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config

    # Restart sshd
    service ssh restart

    echo "Disabled root login successfully."
else
    echo "DISABLE_ROOT_LOGIN not set or false, skipping..."
fi
