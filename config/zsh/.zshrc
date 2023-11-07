pfetch

setopt PROMPT_SUBST
PROMPT='%F{blue}%m%f %F{green}%/%f -> '
RPROMPT='%D{%H:%M}'

# Completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Alias
source $HOME/.config/zsh/aliasrc

# fzf
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

export FZF_DEFAULT_OPTS='--color=fg:15,bg:-1,hl:13 --color=fg+:15,bg+:-1,hl+:13 --color=info:3,prompt:2,pointer:4 --color=marker:4,spinner:3,header:240'

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
