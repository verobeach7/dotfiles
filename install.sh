#!/usr/bin/env bash
set -e

echo "🚀 Starting development environment setup..."

# --------------------------------------------------
# symlinks
# --------------------------------------------------
echo "🔗 Creating symlinks..."

mkdir -p "$HOME/.config"
ln -sfn "$HOME/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$HOME/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sfn "$HOME/dotfiles/zsh/.zprofile" "$HOME/.zprofile"
ln -sfn "$HOME/dotfiles/zsh/p10k.zsh" "$HOME/.p10k.zsh"
ln -sFn "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
ln -sFn "$HOME/dotfiles/tmux/tmuxinator" "$HOME/.config/tmuxinator"

# --------------------------------------------------
# Homebrew packages
# --------------------------------------------------
echo "🍺 Installing Brew packages..."
if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew not found. Install it first:"
  echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  exit 1
fi
brew bundle --file="$HOME/dotfiles/brew/Brewfile"

# --------------------------------------------------
# Node (nvm)
# --------------------------------------------------
echo "🟢 Installing nvm and Node LTS..."

export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
  NVM_LATEST=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_LATEST/install.sh" | bash
fi

# load nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

set +e
nvm install --lts
nvm use --lts
nvm alias default lts/*
set -e

# --------------------------------------------------
# Python (pyenv)
# --------------------------------------------------
echo "🐍 Installing Python via pyenv..."

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null; then
  eval "$(pyenv init -)"
  pyenv install -s 3.13
  pyenv global 3.13
fi

# --------------------------------------------------
# Claude Code (official installer)
# --------------------------------------------------
echo "🤖 Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

# --------------------------------------------------
# LazyVim plugins sync
# --------------------------------------------------
echo "🧠 Installing Neovim plugins (LazyVim)..."
nvim --headless -c 'autocmd User LazySync qall' -c 'Lazy! sync'

# --------------------------------------------------
# tmux plugin manager (TPM)
# --------------------------------------------------
echo "🧩 Installing tmux plugins..."

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# install tmux plugins automatically
tmux start-server
tmux new-session -d -s __temp
tmux source-file "$HOME/.tmux.conf"
"$HOME/.tmux/plugins/tpm/bin/install_plugins"
tmux kill-session -t __temp

# --------------------------------------------------
# Done
# --------------------------------------------------
echo "✅ Development environment setup complete!"
echo "👉 Restart terminal or run: source ~/.zshrc"
