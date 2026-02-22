#!/usr/bin/env bash

echo "🔧 Applying macOS settings..."

# UX
# 키 반복 속도
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
# 트랙패드 탭 클릭
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# 트랙패드 커서 이동 속도 증가
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

# Finder
# Finder 숨김 파일 표시
defaults write com.apple.finder AppleShowAllFiles YES
# 현재 디렉토리 경로 항상 표시
defaults write com.apple.finder ShowPathbar -bool true
# 상태바 표시
defaults write com.apple.finder ShowStatusBar -bool true
# 기본 보기 리스트로 설정
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Dock
# Dock 자동 숨김
defaults write com.apple.dock autohide -bool true
# Dock 숨김 애니메이션 빠르
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5
# Dock 최근 앱 표시 제거
defaults write com.apple.dock show-recents -bool false

# Dev UX
# 코드 입력 방해 요소 제거
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# 파일 확장자 항상 표시
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

killall Finder
killall Dock
