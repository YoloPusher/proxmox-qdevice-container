#!/bin/bash
set -e

if [ "$DISABLE_PASSWORD_AUTH" = "true" ]; then
    echo "Waiting for sshd to come up..."

    # Wait until sshd is listening on port 22
    while ! ss -lnt | grep -q ":22 "; do
        sleep 1
    done

    echo "Disabling password authentication..."

    # Disable password authentication in sshd
    sed -i 's/^PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

    # Restart sshd
    service ssh restart

    echo "Disable password authentication successfully."
else
    echo "DISABLE_PASSWORD_AUTH not set or false, skipping..."
fi
