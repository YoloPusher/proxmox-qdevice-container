#!/bin/bash

if [ -n "$ROOT_PASSWORD_HASH" ]; then
    echo "Updating root password..."
    usermod -p "$ROOT_PASSWORD_HASH" root
    echo "Root password updated successfully."
else
    echo "ROOT_PASSWORD_HASH not set in environment, skipping root password update..."
fi
