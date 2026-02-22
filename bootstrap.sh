#!/usr/bin/env bash
set -e

echo "🛠 Installing Xcode CLI..."
xcode-select --install 2>/dev/null || true

echo "🍺 Installing Homebrew..."
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "📥 Cloning dotfiles..."
if [ ! -d "$HOME/dotfiles" ]; then
  git clone https://github.com/verobeach7/dotfiles.git ~/dotfiles
fi

cd ~/dotfiles

echo "🔗 Running install script..."
./install.sh

echo "⚙️ Applying macOS defaults..."
./macos.sh

echo "🚀 Setup complete"
