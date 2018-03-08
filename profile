#!/bin/bash
if ! $(which profile_loaded >/dev/null); then
alias profile_loaded="true"

[[ -f ~/.profile.before ]] && . ~/.profile.before

[[ -z $LC_ALL ]] && export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

function add_to_path {
  local DIR=$1
  if [ "$(grep $DIR -c <<< $PATH)" -eq "1" ]; then
    PATH=$DIR:$(sed s,$DIR,, <<< $PATH)
    PATH=$(sed -E s,:+,:,g <<< $PATH)
  else
    PATH=$DIR:$PATH
  fi
}

function append_to_path {
  local DIR=$1
  if [ "$(grep $DIR -c <<< $PATH)" -eq "1" ]; then
    PATH=$(sed s,$DIR,, <<< $PATH):$DIR
    PATH=$(sed -E s,:+,:,g <<< $PATH)
  else
    PATH=$PATH:$DIR
  fi
}

source ~/.dotfiles/terminal
source ~/.dotfiles/aliases
source ~/.dotfiles/docker
source ~/.dotfiles/git
source ~/.dotfiles/xcode
source ~/.dotfiles/golang
source ~/.dotfiles/ruby
source ~/.dotfiles/python

add_to_path ~/bin
add_to_path ~/.dotfiles/bin

export EDITOR=$(which nvim vim | grep -v 'not found' | head -n 1)
export VISUAL=$EDITOR


if [[ -n `which unsetopt` ]]; then
  # Fix multi-terminal history
  unsetopt SHARE_HISTORY

  # Fix the "no matches found" error when trying to
  # pass an asterisk to a command
  unsetopt nomatch 2>/dev/null
fi

# RVM (once)
#grep .rvm >/dev/null<<<$PATH || [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
#add_to_path ~/.rvm/bin

# chruby
[[ -f /usr/local/share/chruby/chruby.sh ]] && source /usr/local/share/chruby/chruby.sh
[[ -f /usr/local/share/chruby/auto.sh ]] && source /usr/local/share/chruby/auto.sh

# Vi!?
#set -o vi

# Don't you dare decide this for me
export HOMEBREW_NO_AUTO_UPDATE=1

# Apptivate shortcuts
alias apptivate_show='defaults write se.cocoabeans.apptivate TAShowStatusbarIcon 1'
alias apptivate_hide='defaults write se.cocoabeans.apptivate TAShowStatusbarIcon 0'

function profile {
  $EDITOR ~/.profile.local && source ~/.profile.local
}

[[ -f ~/.profile.local ]] && . ~/.profile.local

fi # end profile_loaded()
