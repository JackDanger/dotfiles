ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[green]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}臟%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Fail:
# PROMPT='%(?, ,%{$fg[red]%}FAIL: $?%{$reset_color%})'
# Original:
# PROMPT='%{$fg[red]%}%n%{$reset_color%}%{$fg[yellow]%}@%m%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info)

PROMPT='%{$fg[red]%}$(pwd | xargs -I {} basename "{}")%{$reset_color%} $(git_prompt_info)%{$fg[red]%}$%{$reset_color%} '

RPROMPT='%(?..%{$fg[green]%}%?%{$reset_color%})'
