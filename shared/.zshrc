# Oh My Zsh Settings
export ZSH="$HOME/.oh-my-zsh" # Path to OMZ config
zstyle ':omz:update' mode disabled  # disable auto updates, chezmoi handles this
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

alias sr="source"
alias cv="cvault"
alias gitig="touch .gitignore && echo -e '*.env\n*.DS_Store\n.idea\n.claude' >> .gitignore" # Create a .gitignore file with common entries
alias lg="lazygit"
alias n="nvim"
alias nn="NVIM_APPNAME=nvim-new nvim"
alias t="tmux"
alias nvnv="cd ~/.config/nvim && nvim"

# Tmux sesh connect
sc() {
    sesh connect $(sesh list | fzf)
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

eval "$(zoxide init zsh --cmd cd)"

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions
