# Oh My Zsh Settings
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode disabled
ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-vi-mode
    vscode)

ZSH_AUTOSUGGEST_STRATEGY=(
    completion
    history
)

source $ZSH/oh-my-zsh.sh

# Get environmental variables from ~/.env_vars if it exists (in order to keep separate env variables per computer)
if [ -f ~/.env_vars ]; then
    source ~/.env_vars
fi

# Universal Aliases / Env Vars
# set editor to nvim if present - used for sudoedit
if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
fi

alias lg="lazygit"
alias n="nvim"
alias sc="tv sesh"
alias sr="source"
alias t="tmux"
alias y="yazi"

prj() {
    local proj_dir="$HOME/Projects"
    if [[ -d "$proj_dir" ]]; then
        cd "$proj_dir"
    else
        echo "$proj_dir not found" >&2
        return 1
    fi
}

# Go Env Vars
if [ -d /usr/local/go ]; then
    export GOROOT=/usr/local/go
    export PATH=$PATH:$GOROOT/bin
fi

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH 
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export ZVM_VI_EDITOR=nvim

# Completions
fpath=(~/.docker/completions ~/.zsh/completions $fpath)
autoload -U compinit && compinit

eval "$(tv init zsh)"

function zvm_after_init() {
    bindkey '^[v' tv-smart-autocomplete # alt-v
    bindkey '^R' tv-shell-history # ctrk-r
    bindkey '^[r' tv-shell-history # alt-r
}

[[ -o interactive ]] && eval "$(zoxide init zsh --cmd cd)"

# bun completions
[ -s "/home/danny/.local/share/reflex/bun/_bun" ] && source "/home/danny/.local/share/reflex/bun/_bun"

# bun
export BUN_INSTALL="$HOME/.local/share/reflex/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
