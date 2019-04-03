#!/bin/bash

which brew &>/dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew install \
  fzf\
  git \
  golang \
  macvim

brew cask install aws-vault
