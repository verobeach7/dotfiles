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

Set display resolution to 2/5 (if 5k monitor)

### Safari

Zoom 125% (if 5k monitor)

### Chrome

Zoom 125% (if 5k monitor)

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

### Karabiner

Karabiner-Elements Configuration

This repository includes a configuration for Karabiner-Elements to optimize keyboard behavior in a terminal-focused development environment, especially when using iTerm2 and tmux.

#### Overview

Automatic input source switching in iTerm2

When specific modifier keys are pressed in iTerm2, the input source automatically switches to ABC (English). The original key event is then passed through normally.

##### Ctrl + A

    • Switches input source to ABC
    • Sends Ctrl + A afterward
    • Prevents issues when using tmux or shell prefix keys while typing in Korean

##### Option key

    • Switches input source to ABC
    • Keeps Option key behavior unchanged
    • Helps avoid accidental input source problems when using Meta shortcuts

##### Key Remappings

Caps Lock → F19
• Used as a Hyper key or custom shortcut trigger

Right Command → Caps Lock
• Used as a quick language switch key

#### Target Device

This configuration currently applies only to a specific keyboard.

Vendor ID: 13652
Product ID: 64007

If you want the same behavior on other keyboards, add their device identifiers.

#### Design Goals

This setup is designed for a workflow that relies heavily on terminal shortcuts.
• Smooth tmux and shell key usage
• Automatic input source management
• Extensible foundation for Hyper key shortcuts
