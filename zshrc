# Minimal fast zsh config - no prezto, no bloat
# Target: < 50ms startup time

# Emacs keybindings (CTRL-A, CTRL-E, etc.)
bindkey -e
bindkey "^o" clear-screen

# Shell options
setopt nocorrectall
setopt CLOBBER
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt PROMPT_SUBST

# History
SAVEHIST=100000000
HISTSIZE=100000000
HISTFILE="$HOME/.zsh_history"
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history_time
setopt no_hist_beep
setopt extendedhistory
unsetopt SHARE_HISTORY

# Colors
autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# FZF - fast and useful
export FZF_TMUX=0
export FZF_CTRL_T_OPTS='--height 40% --reverse --preview "cat {} 2>/dev/null | head -100"'
export FZF_CTRL_R_OPTS='--height 40%'
export FZF_ALT_C_OPTS='--height 40% --reverse'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.dotfiles/zsh/fzf-key-bindings.zsh ] && source ~/.dotfiles/zsh/fzf-key-bindings.zsh

# Prompt - simple and fast
branch_and_dirty() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
  echo -n "%B%F{yellow}$branch %b"
  if ! git diff --no-ext-diff --quiet HEAD 2>/dev/null; then
    echo -n "%B%F{yellow}骯%b"
  fi
}

PS1='%F{green}%1~%f $(branch_and_dirty)%f%F{red}$%f '

# Source your actual config
source ~/.dotfiles/profile

# ASDF - just add shims to PATH (fast)
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
export PATH="${ASDF_DATA_DIR}/shims:$PATH"

# Lazy-load completion system on first Tab press
# This is the key optimization - compinit takes 300ms+, defer it
_load_completion() {
  unset -f _load_completion
  autoload -Uz compinit
  # Use cached completion dump, regenerate daily
  local zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
  if [[ -f "$zcompdump" && $(date +'%j') == $(stat -f '%Sm' -t '%j' "$zcompdump" 2>/dev/null) ]]; then
    compinit -C -d "$zcompdump"
  else
    mkdir -p "${zcompdump:h}"
    compinit -d "$zcompdump"
  fi
  # Basic completion settings
  zstyle ':completion:*' menu select
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
}

# Bind Tab to load completion on first use, then do normal completion
_first_tab() {
  _load_completion
  zle expand-or-complete
}
zle -N _first_tab
bindkey '^I' _first_tab

# After first tab, rebind to normal completion
_load_completion_and_rebind() {
  _load_completion
  bindkey '^I' expand-or-complete
  zle expand-or-complete
}
zle -N _load_completion_and_rebind
bindkey '^I' _load_completion_and_rebind

# GITHUB_TOKEN cache (background refresh)
_gh_token_cache="$HOME/.cache/gh_token"
if [[ -f "$_gh_token_cache" ]] && [[ $(find "$_gh_token_cache" -mmin -60 2>/dev/null) ]]; then
  export GITHUB_TOKEN="$(cat "$_gh_token_cache" 2>/dev/null)"
else
  {
    mkdir -p "$HOME/.cache" 2>/dev/null
    local token="$(gh auth token 2>/dev/null)"
    [[ -n "$token" ]] && echo "$token" > "$_gh_token_cache"
    export GITHUB_TOKEN="$token"
  } &!
fi
unset _gh_token_cache

# LaunchDarkly RC - lazy load on first prompt if present
if [[ -f ~/.launchdarklyrc ]]; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH:$HOME/.local/bin:$HOME/code/launchdarkly/dev/bin"
  export AWS_SDK_LOAD_CONFIG=true
  export TENV_AUTO_INSTALL="true"
  [[ -n "$GITHUB_TOKEN" ]] && export HOMEBREW_GITHUB_API_TOKEN="$GITHUB_TOKEN"

  _load_launchdarkly_rc() {
    precmd_functions=(${precmd_functions[@]:#_load_launchdarkly_rc})
    eval "$(goenv init -)" 2>/dev/null
    go env -w "GOPRIVATE=github.com/launchdarkly" 2>/dev/null || true
    alias awslogin_launchdarkly="awslogin launchdarkly-default"
    alias awslogin_federal="awslogin federal-default"
  }
  precmd_functions=(_load_launchdarkly_rc $precmd_functions)
fi
