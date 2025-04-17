#!/bin/sh

# https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user

if [ "$(id -u)" -eq 0 ]; then
    if [ -z "$1" ]; then
        echo "❌ Please provide a username as the first argument. Example: $0 username"
        exit 1
    fi
    TARGET_USER="$1"
else
    TARGET_USER="$USER"
fi

if ! getent group docker > /dev/null; then
    sudo groupadd docker
fi

sudo usermod -aG docker "$TARGET_USER"

echo "✅ Added '$TARGET_USER' to group 'docker'"
echo "💡 You can run the following command to activate the group change (for non-root users)"
echo ""
echo "    newgrp docker"
echo ""
echo "⚠️ Please restart your session, logout and log back in to apply the group changes without needing to run 'newgrp'."
