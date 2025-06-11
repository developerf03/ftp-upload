#!/bin/bash

set -e  # Stop on error

# 📍 Get absolute path to the directory where install.sh resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 📍 CDN URLs
JS_URL="https://assets.x9rtlt.xyz/tools/ftp-upload/ftp-upload.js"
PKG_URL="https://assets.x9rtlt.xyz/tools/ftp-upload/package.json"

# 📍 File paths
SCRIPT_PATH="$SCRIPT_DIR/ftp-upload.js"
PACKAGE_JSON_PATH="$SCRIPT_DIR/package.json"

# 📥 Download files
echo "🌐 Downloading ftp-upload.js..."
curl -fsSL "$JS_URL" -o "$SCRIPT_PATH"

echo "🌐 Downloading package.json..."
curl -fsSL "$PKG_URL" -o "$PACKAGE_JSON_PATH"

# 📦 Install npm dependencies
echo "📦 Installing npm dependencies..."
cd "$SCRIPT_DIR"
npm install

# 🔧 Make script executable
echo "🔧 Making ftp-upload.js executable..."
chmod +x "$SCRIPT_PATH"

# 🔗 Create symlink
TARGET_LINK="/usr/local/bin/xdeploy"
echo "🔗 Creating symlink at $TARGET_LINK..."
if [ -L "$TARGET_LINK" ] || [ -f "$TARGET_LINK" ]; then
    echo "⚠️ Removing existing file or symlink at $TARGET_LINK"
    sudo rm -f "$TARGET_LINK"
fi
sudo ln -s "$SCRIPT_PATH" "$TARGET_LINK"

echo "✅ Installed successfully! Run the CLI with: xdeploy"
