#!/usr/bin/env bash
set -e

echo "🚀 Starting development environment setup..."

# --------------------------------------------------
# symlinks
# --------------------------------------------------
echo "🔗 Creating symlinks..."

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/karabiner"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/tmuxinator"

ln -sfn "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$HOME/dotfiles/zsh/zshrc" "$HOME/.zshrc"
ln -sfn "$HOME/dotfiles/zsh/.zprofile" "$HOME/.zprofile"
ln -sfn "$HOME/dotfiles/zsh/p10k.zsh" "$HOME/.p10k.zsh"
ln -sfn "$HOME/dotfiles/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
ln -sFn "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
ln -sFn "$HOME/dotfiles/tmux/tmuxinator" "$HOME/.config/tmuxinator"

# --------------------------------------------------
# Homebrew packages
# --------------------------------------------------
echo "🍺 Installing Brew packages..."
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed, skipping"
fi

if ! brew bundle --file="$HOME/dotfiles/brew/Brewfile"; then
  echo "⚠️ Brew bundle failed"
  brew bundle check --file="$HOME/dotfiles/brew/Brewfile"
fi

# --------------------------------------------------
# Zsh setup (Oh My Zsh + plugins + theme)
# --------------------------------------------------
echo "🐚 Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "⚡ Installing Powerlevel10k..."
if [ ! -d "$HOME/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
fi

echo "💡 Installing zsh-autosuggestions..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

echo "🎨 Installing zsh-syntax-highlighting..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

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
set +e
nvim --headless -c 'autocmd User LazySync qall' -c 'Lazy! sync'
set -e

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
