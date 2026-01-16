#!/bin/bash

echo "Removing AWS CLI v2..."

# 1. Find the install and symlink paths
# Default paths are /usr/local/aws-cli and /usr/local/bin/aws
INSTALL_PATH=$(which aws)

if [ -z "$INSTALL_PATH" ]; then
    echo "❓ AWS CLI not found in PATH."
else
    # Resolve the symlink to find the actual installation directory
    REAL_PATH=$(readlink -f $INSTALL_PATH)
    BIN_DIR=$(dirname $INSTALL_PATH)
    INSTALL_DIR=$(dirname $(dirname $REAL_PATH))

    echo "Deleting binaries in $BIN_DIR..."
    sudo rm -f $BIN_DIR/aws
    sudo rm -f $BIN_DIR/aws_completer

    echo "Deleting installation files in $INSTALL_DIR..."
    sudo rm -rf $INSTALL_DIR
fi

# Optional: Remove configuration files
# rm -rf ~/.aws

echo "✅ AWS CLI has been removed."