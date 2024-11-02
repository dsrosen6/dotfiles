# Oh My Zsh Settings
export ZSH="$HOME/.oh-my-zsh" # Path to OMZ config
zstyle ':omz:update' mode reminder  # Update behavior - inform when available
ZSH_THEME=""

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
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

# Aliases
alias zshconf="code ~/.zshrc" # Opens this file in VS Code. Requires VSCode "code" command
alias zshsrc="source ~/.zshrc" # Shortcut to source this file.
alias ssconf="code ~/.config/starship.toml"
alias python="python3"
alias byebye="python3 ~/byebye-py/byebye.py" # Run byebye.py script to hide all open apps
alias gitig="touch .gitignore && echo -e '*.env\n*.DS_Store' >> .gitignore" # Create a .gitignore file with common entries
alias goland="open -a 'GoLand' --args $@" # Open GoLand from terminal

# Go Env Vars
export GOROOT=/usr/local/go
export GOPATH=/Users/danny/go
export PATH=$GOPATH/bin:$PATH 
export PATH=$PATH:$GOROOT/bin

# Starship
eval "$(starship init zsh)"