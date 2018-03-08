## Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/prezto
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
bindkey -e
bindkey "^o" clear-screen
# # Discovered through:
# # $ echo "<CTRL>v<FN>Del" | od -c
# bindkey "^[[3~" delete-char
# # And get meta-left and meta-right working
# bindkey '\e\e[C' forward-word
# bindkey '\e\e[D' backward-word

# I know what I'm doing
setopt CLOBBER

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins= #(python bundler)

# FZF
export FZF_TMUX=0;
export FZF_CTRL_T_OPTS='--height 40% --reverse --preview "highlight -O ansi -l {} 2>/dev/null || cat {}"'
export FZF_CTRL_R_OPTS='--height 40%';
export FZF_ALT_C_OPTS='--height 40% --reverse';
export FZF_COMPLETION_OPTS='--height 40% --reverse';
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $HOME/.dotfiles/zsh/fzf-key-bindings.zsh

# Prezto ZSH
fpath=(~/.dotfiles/zsh $fpath)
source $HOME/.dotfiles/zsh/git-completion.zsh
source $ZSH/init.zsh
source $ZSH/runcoms/zshrc
#zstyle ":prezto:module:prompt" theme "jackdanger"
autoload -Uz promptinit && promptinit
prompt jackdanger

SAVEHIST=10000000
HISTSIZE=10000000
HISTFILE="$HOME/.zsh_history"
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history_time
setopt no_hist_allow_clobber
setopt no_hist_beep
setopt extendedhistory

# I know what I'm doing
setopt CLOBBER

export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Direnv
#if [[ -n "$(which direnv)" ]]; then
#  eval "$(direnv hook $0)"
#fi

source ~/.dotfiles/profile

if which direnv >/dev/null 2>/dev/null; then
  eval "$(direnv hook zsh)"
fi

branch_and_dirty() {
  if [[ -d .git ]]; then
    git rev-parse --abbrev-ref HEAD | tr "\n" " "
    if [[ -n $(git diff-index --cached HEAD --) ]] ||
       [[ -n $(git ls-files --exclude-standard -o -m -d) ]]; then
      echo -n 臟
    fi
  fi
}
PS1='%{$fg[red]%}$(pwd | xargs -I {} basename "{}")%f%b %{$fg_bold[green]%}$(branch_and_dirty)%f%b%{$fg[red]%}$ %f%b'
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
>/dev/null which virtualenvwrapper.sh && source $(which virtualenvwrapper.sh)
