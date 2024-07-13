# Oh My Zsh Settings
export ZSH="$HOME/.oh-my-zsh" # Path to OMZ config
zstyle ':omz:update' mode reminder  # Update behavior - inform when available
ZSH_THEME="refined" # Set Oh My Zsh theme

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    vscode)

ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)

source $ZSH/oh-my-zsh.sh

# Enable Pure
# fpath+=($HOME/.zsh/pure)
# autoload -U promptinit; promptinit
# prompt pure

# Get environmental variables from ~/.env_vars if it exists (in order to keep separate env variables per computer)
if [ -f ~/.env_vars ]; then
    source ~/.env_vars
fi

# Aliases
alias zshconf="code ~/.zshrc" # Opens this file in VS Code. Requires VSCode "code" command
alias zshsrc="source ~/.zshrc" # Shortcut to source this file.
alias python="python3"

# Go Env Vars
export GOROOT=/usr/local/go
export GOPATH=/Users/danny/go
export PATH=$GOPATH/bin:$PATH 
export PATH=$PATH:$GOROOT/bin
