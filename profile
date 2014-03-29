[[ -f ~/.profile.before ]] && . ~/.profile.before

source ~/.dotfiles/terminal
source ~/.dotfiles/aliases
source ~/.dotfiles/git
source ~/.dotfiles/golang
source ~/.dotfiles/ruby
source ~/.dotfiles/z.sh

PATH=~/bin:$PATH
PATH=~/.dotfiles/bin:$PATH

if [[ -n `which unsetopt` ]]; then
  # Fix multi-terminal history
  unsetopt SHARE_HISTORY

  # Fix the "no matches found" error when trying to
  # pass an asterisk to a command
  unsetopt nomatch 2>/dev/null
else
  echo "Unsetopt doesn't exist"
fi

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Vi!
#set -o vi

[[ -f ~/.profile.local ]] && . ~/.profile.local
