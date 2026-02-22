# verobeach7's dotfiles

## Overview

dotfiles for MacOS(Apple Silicon)
Opinionated macOS development environment

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

```zsh
./install.sh
```

### Install plugins

#### Neovim

```vim
:Lazy sync
```

#### tmux

```vim
prefix + I
```

## MacOS Settings

### 디스플레이 설정

디스플레이 크기 조정 2/5

### Safari

보기 125%

### Chrome

**보기 125%**

### Karabiner

설정 백업 복원

### iTerm2

설정 백업 복원

## Checklist

- [ ] tmux 설정 반영 여부 확인
- [ ] nvim plugins 설치 확인
- [ ] terminal alias 확인
- [ ] terminal, iterm scroll 정상 동작 확인

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
