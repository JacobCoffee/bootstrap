#!/bin/bash

# =========================
# Update Apt
# =========================
echo "Updating Apt" && sudo apt-get update

# =========================
# Apt install:
#       - pip
#       - fish shell
#       - alacritty
#       - neovim
#       - git-crypt
# =========================
for i in python3-pip fish alacritty neovim git-crypt; do
  echo "Installing $i" && sudo apt-get install -y $i
done

# =========================
# Install Ansible
# =========================
echo "Installing Ansible" && sudo pip3 install ansible

# =========================
# Install Starship prompt
# =========================
echo "Installing starship prompt" && curl -fsSL https://starship.rs/install.sh | bash

# =========================
# Install Rust
# =========================
echo "Installing Rust" && curl https://sh.rustup.rs -sSf | sh

# =========================
# Configure Alacritty
# =========================
echo "Configuring Alacritty" && cp config/alacritty.yml "$HOME"/.config/alacritty/alacritty.yml
echo "Setting Dracula theme" && curl -L https://github.com/dracula/alacritty/archive/master.zip -o dracula.zip
unzip dracula.zip && cp alacritty-master/dracula.yml "$HOME".config/alacritty/dracula.yml && rm dracula.zip rm -r alacritty-master

# =========================
# Configure Fish
# =========================
# Install OMF
echo "Installing Oh My Fish" && curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
# Copy config
echo "Configuring Fish" && cp -r config/fish "$HOME"/.config/fish
# Configure Starsip prompt for Fish shell
echo "Configuring Starship prompt for Fish shell" && echo "starship init fish | source" >>"$HOME".config/fish/config.fish

# =========================
# Configure Vim
# =========================
echo "Configuring Vim" && cp config/.vimrc "$HOME"/.vimrc
echo "Installing powerline" && pip install --user powerline-status
echo "Installing Vundle"
mkdir -p "$HOME"/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim.git "$HOME".vim/bundle/Vundle.vim
echo "Installing Vim plugins" && cp -r config/vimrc "$HOME"/.vimrc && vim +PluginInstall +qall

# =========================
# Configure Starship
# =========================
echo "Configuring Starship" && cp config/starship "$HOME"/.config/starship.toml

# =========================
# Copy the *.priv files to $HOME
# =========================
cp config/*.priv "$HOME"/
echo "Encrypted files copied to $HOME - You will need to decrypt them and move them to the correct location"