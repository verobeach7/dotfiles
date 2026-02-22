# verobeach7's dotfiles

## Overview

Opinionated macOS (Apple Silicon) development environment dotfiles.

## Auto Installation

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/verobeach7/dotfiles/main/bootstrap.sh)"
```

## Manual Installation

### Xcode CLI

```zsh
xcode-select --install
```

### Install Homebrew

<https://brew.sh/>

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### dotfiles Clone

```zsh
git clone https://github.com/verobeach7/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Install script

Creates symlinks and installs Homebrew packages, Node (nvm), Python (pyenv), Claude Code, and tmux/Neovim plugins.

```zsh
./install.sh
```

Applies macOS system defaults (Finder, Dock, trackpad, keyboard settings).

```zsh
./macos.sh
```

### Install plugins

#### Neovim

```vim
:Lazy sync
```

#### tmux

```text
prefix + I
```

## MacOS Settings

> The following settings cannot be automated via scripts and must be configured manually.

### Display

Set display resolution to 2/5

### Safari

Zoom 125%

### Chrome

Zoom 125%

### Karabiner

Restore settings from backup

### iTerm2

Restore settings from backup

## Checklist

- [ ] Verify tmux config is applied
- [ ] Verify nvim plugins are installed
- [ ] Verify terminal aliases
- [ ] Verify terminal and iTerm scroll works correctly

## Details

### im-select

#### Input Method Auto Switch (macOS)

This config uses `im-select` to automatically switch the keyboard input
to **English when entering Normal mode** in Neovim.

It prevents keybindings from breaking when the system input source is set
to Korean (or any non-English layout).

##### Requirement

- macOS
- `im-select` installed

##### Behavior

- Insert mode → keeps your previous input method
- Normal mode → forces English layout
