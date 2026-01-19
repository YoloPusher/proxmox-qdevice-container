#!/bin/bash
set -e

NSSDB_DIR="/etc/corosync/qnetd/nssdb"

if [ ! -d "$NSSDB_DIR" ] || [ -z "$(ls -A "$NSSDB_DIR" 2>/dev/null)" ]; then
    echo "[qnetd-init] NSS DB not found, initializing..."
    corosync-qnetd-certutil -i
    chown -R coroqnetd:coroqnetd /etc/corosync/qnetd
else
    echo "[qnetd-init] NSS DB already exists, skipping init"
fi
