source ~/.dotfiles/terminal
source ~/.dotfiles/aliases
source ~/.dotfiles/git
source ~/.dotfiles/ruby
source ~/.dotfiles/z.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

PATH=$PATH:~/bin
PATH=$PATH:~/.dotfiles/bin

# Fix multi-terminal history
unsetopt SHARE_HISTORY

# Fix the "no matches found" error when trying to
# pass an asterisk to a command
unsetopt nomatch 2>/dev/null

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

