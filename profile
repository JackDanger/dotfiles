if [[ -z $PROFILE_LOADED ]]; then
PROFILE_LOADED=PROFILE_LOADED

[[ -f ~/.profile.before ]] && . ~/.profile.before

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

source ~/.dotfiles/terminal
source ~/.dotfiles/aliases
source ~/.dotfiles/docker
source ~/.dotfiles/git
source ~/.dotfiles/golang
source ~/.dotfiles/ruby

add_to_path ~/bin
add_to_path ~/.dotfiles/bin

export EDITOR=vim

if [[ -n `which unsetopt` ]]; then
  # Fix multi-terminal history
  unsetopt SHARE_HISTORY

  # Fix the "no matches found" error when trying to
  # pass an asterisk to a command
  unsetopt nomatch 2>/dev/null
else
  echo "Unsetopt doesn't exist"
fi

# RVM (once)
grep .rvm >/dev/null<<<$PATH || [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
add_to_path ~/.rvm/bin

# Vi!
#set -o vi

function profile {
  $EDITOR ~/.profile.local && source ~/.profile.local
}

[[ -f ~/.profile.local ]] && . ~/.profile.local

fi # end $PROFILE_LOADED
