## Path to your oh-my-zsh configuration.
ZSH=$HOME/.zprezto
ZSH_CUSTOM=$HOME/.dotfiles/zsh

# Homebrew told me so
HOMEBREW_HELP=/usr/local/share/zsh/help
if [ -d $HOMEBREW_HELP ]; then
  unalias run-help
  autoload run-help
  HELPDIR=$HOMEBREW_HELP
fi

# COWBOY TIME
setopt nocorrectall
DISABLE_CORRECTION=true

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jackdanger"

# Example aliases
alias profile="vim ~/.zshrc && . ~/.zshrc"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# We'll be using CTRL-l elsewhere
bindkey "^o" clear-screen

# I know what I'm doing
setopt CLOBBER

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins= #(python bundler)

# Oh-My-Zsh
# source $ZSH/oh-my-zsh.sh
# Prezto
fpath=(~/.dotfiles/zsh $fpath)
source $ZSH/runcoms/zshrc
#zstyle ":prezto:module:prompt" theme "jackdanger"
autoload -Uz promptinit && promptinit
prompt jackdanger

# I know what I'm doing
setopt CLOBBER

export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Direnv
#if [[ -n "$(which direnv)" ]]; then
#  eval "$(direnv hook $0)"
#fi

# Fix autocorrect
if [ -f ~/.zsh_nocorrect ]; then
  while read -r COMMAND; do
    alias $COMMAND="nocorrect $COMMAND"
  done < ~/.zsh_nocorrect
fi

if [[ -n `which direnv` ]]; then
  eval "$(direnv hook zsh)"
fi

source ~/.dotfiles/profile
source ~/.fzf.zsh
source $HOME/.dotfiles/zsh/git-completion.zsh
