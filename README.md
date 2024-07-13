Steps to install:

1. Install [GNU Stow](https://www.gnu.org/software/stow/)
2. Remove any existing `.zshrc` file from your home folder since the next step will create a new one
3. Clone this repo into your home folder, `cd` to it, then run `stow .` in order to create the symlink to the `.zshrc` file from the repo
4. `cd` back to ~
5. Install oh-my-zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc` (this command will install it without replacing `.zshrc`)
6. Install zsh-autosuggestions into oh-my-zsh plugins: `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
7. Install zsh-syntax-highlighting into oh-my-zsh plugins: `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
