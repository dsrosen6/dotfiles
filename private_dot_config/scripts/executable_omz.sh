#!/usr/bin/env bash
if ! git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh; then
    echo "Failed to clone oh-my-zsh repository. It may already exist"
fi

current_shell=$(basename "$SHELL")
if [[ "$current_shell" != "zsh" ]]; then
    echo "Changing default shell to zsh..."
    if which zsh 2>&1; then
        chsh -s $(which zsh)
        echo "Default shell changed to zsh. A restart may be needed."
    else
        echo "Error: zsh is not installed"
        exit 1
    fi
else
    echo "Already using zsh as default shell"
fi

if ! git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions; then
    echo "Couldn't clone zsh-autosuggestions - it may already exist"
fi

if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting; then
    echo "Couldn't clone zsh-syntax-highlighting - it may already exist"
fi

echo "Done. Close the terminal and reopen it - if oh my zsh doesn't show, you may need to restart."
