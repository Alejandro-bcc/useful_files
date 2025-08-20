#!/bin/bash

REMOTE_USER="adnn24"
REMOTE_HOST="ssh.inf.ufpr.br"
REMOTE_PATH="/home/bcc/adnn24/Materias"
LOCAL_MOUNT="$HOME/Materias-remoto"

mkdir -p "$LOCAL_MOUNT"

if mountpoint -q "$LOCAL_MOUNT"; then
    exit 0
fi

sshfs "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH" "$LOCAL_MOUNT" \
    -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,follow_symlinks

if [ $? -eq 0 ]; then
    echo
else
    echo "Failed to mount"
    exit 1
fi
