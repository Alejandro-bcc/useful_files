#!/bin/bash

# Add this in your .bashrc file to automatically mount 
# the remote Materias folder when 
# using 'cd Materias-remoto' or 'cd ~/Materias-remoto':
#
# cd(){
#     TARGET="$1"
#     # Expand ~ to $HOME
#     [[ "$TARGET" == "~/"* ]] && TARGET="${HOME}/${TARGET:2}"
#     # Convert relative to absolute
#     ABS_TARGET="$(readlink -f "$TARGET" 2>/dev/null)"
#     if [[ "$ABS_TARGET" == "$HOME/Materias-remoto" ]]; then
#         /home/alejandro/mount_materias.sh
#     fi
#     builtin cd "$@"
# }

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
    echo "Successfully mounted"
else
    echo "Failed to mount"
    exit 1
fi
