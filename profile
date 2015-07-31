if ! $(which profile_loaded >/dev/null); then
function profile_loaded {}

[[ -f ~/.profile.before ]] && . ~/.profile.before

export LC_ALL="en_US.UTF-8"
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

source ~/.dotfiles/terminal
source ~/.dotfiles/aliases
source ~/.dotfiles/docker
source ~/.dotfiles/git
source ~/.dotfiles/xcode
source ~/.dotfiles/golang
source ~/.dotfiles/ruby

add_to_path ~/bin
add_to_path ~/.dotfiles/bin

# Use Neovim by default
if [[ -z "$(which nvim)" ]]; then
  export EDITOR=/usr/local/bin/vim
  export VISUAL=$EDITOR
else
  export EDITOR=$(which nvim)
  export VISUAL=$EDITOR
fi


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
#grep .rvm >/dev/null<<<$PATH || [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
#add_to_path ~/.rvm/bin

# chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Vi!?
#set -o vi

function profile {
  $EDITOR ~/.profile.local && source ~/.profile.local
}

[[ -f ~/.profile.local ]] && . ~/.profile.local

fi # end profile_loaded()
