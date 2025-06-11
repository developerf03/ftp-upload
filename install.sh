#!/bin/bash

set -e  # Stop on error

# 📍 Get absolute path to the directory where install.sh resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 📍 Full path to the JS script (assumes ftp-upload.js is in the same directory)
SCRIPT_PATH="$SCRIPT_DIR/ftp-upload.js"

# 📍 Define the target symlink location
TARGET_LINK="/usr/local/bin/xdeploy"

echo "📦 Installing npm dependencies..."
cd "$SCRIPT_DIR"
npm install

echo "🔧 Making ftp-upload.js executable..."
chmod +x "$SCRIPT_PATH"

echo "🔗 Creating symlink at $TARGET_LINK..."
if [ -L "$TARGET_LINK" ] || [ -f "$TARGET_LINK" ]; then
    echo "⚠️ Removing existing file or symlink at $TARGET_LINK"
    sudo rm -f "$TARGET_LINK"
fi

sudo ln -s "$SCRIPT_PATH" "$TARGET_LINK"

echo "✅ Installed successfully! Run the CLI with: ftp-upload"
