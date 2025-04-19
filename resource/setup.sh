#!/bin/bash
OMZ_DIR="$HOME/.oh-my-zsh"
CUSTOM_DIR="$HOME/.oh-my-zsh/custom"
AUTOSUGGEST_PATH="$CUSTOM_DIR/plugins/zsh-autosuggestions"
HIGHLIGHT_PATH="$CUSTOM_DIR/plugins/zsh-syntax-highlighting"
FONT_PATH="$HOME/Library/Fonts/JetBrainsMonoNerdFont-Regular.ttf"

if [[ ! -d "$OMZ_DIR" ]]; then
    echo "oh-my-zsh is not installed- please install and then run this script again"
    exit 1
fi

# Install GNU stow
if ! command -v stow >/dev/null 2>&1; then
    if ! command -v brew >/dev/null 2>&1; then
        echo "GNU Stow is not installed, but neither is brew - install homebrew and try again"
    else
        echo "Installing GNU Stow"
        brew install stow
    fi
else
    echo "GNU Stow already installed"
fi

# Install Starship
if ! command -v starship >/dev/null 2>&1; then
    if ! command -v brew >/dev/null 2>&1; then
        echo "Starship is not installed, but neither is brew - install homebrew and try again"
    else
        echo "Installing Starship"
        brew install starship
    fi
else
    echo "Starship already installed"
fi

# Install JetBrains Mono font for iTerm
if [[ ! -f "$FONT_PATH" ]]; then
    if ! command -v brew >/dev/null 2>&1; then
        echo "needed font is not installed, but neither is brew - install homebrew and try again"
    else
        echo "Installing JetBrains Mono font"
        brew install --cask font-jetbrains-mono-nerd-font
    fi
else
    echo "JetBrains Mono font already installed"
fi

# Clone dotfiles repo
if [[ ! -d "$HOME/dotfiles" ]]; then
    echo "Cloning dotfiles repo"
    git clone https://github.com/dsrosen6/dotfiles "$HOME/dotfiles"
else
    echo "dotfiles repo already cloned"
fi

# Remove current .zshrc file
if [[ -f "$HOME/.zshrc" ]]; then 
    echo "Renaming existing .zshrc"
    mv "$HOME/.zshrc" "$HOME/.zshrc_backup"
fi

# Install Zsh plugins & theme
if [[ ! -d "$AUTOSUGGEST_PATH" ]]; then 
    git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGEST_PATH" 
else 
    echo "zsh-autosuggestions plugin already installed"
fi

if [[ ! -d "$HIGHLIGHT_PATH" ]]; then 
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HIGHLIGHT_PATH" 
else
    echo "zsh-syntax-highlighting plugin already installed"
fi

# Make sure ~/.config exists
mkdir -p ~/.config

# Stow contents
cd "$HOME/dotfiles" && stow .zshrc && stow .tmux && stow -t ~/.config starship
echo "Done - quit your terminal and then reopen to apply changes"
