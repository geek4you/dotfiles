#!/usr/bin/env bash

BASE=~/.dotfiles

## run

# Downlaod tmux plugin manager
echo "Installing tmux plugin manager"
if [ ! -d ~/.tmux/plugins/tpm/ ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Download Prezto
echo "Installing Prezto"
if [ ! -d ~/.oh-my-zsh/ ]; then
   git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
fi

cd "$BASE"
git submodule update --init --recursive

echo "Linking..."
files="zshrc bashrc bash_profile bash_aliases profile commonshrc inputrc vim vimrc zpreztorc"
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $BASE/$file ~/.$file
done
echo "Creating symlink to tmux conf"
ln -sf $BASE/tmux/tmux.conf ~/.tmux.conf
echo "Done."

# Download and install fzf
if [ ! -d ~/.fzf/ ]; then
    git clone https://github.com/junegunn/fzf.git ~/.fzf
fi
~/.fzf/install

# Download powerline status
pip install powerline-status

echo "Installing submodules..."

export INSTALLING=true
source ~/.bashrc

echo "Installing gitconfig..."

cd gitconfig
./install.sh
cd "$BASE"

echo "Done."

echo "Installing git-extras..."

cd git-extras
sudo make install
ln -sf $BASE/gitconfig/gitconfig ~/.gitconfig
echo "Done."

#install psutil fot tmux status bar (powerline needs it to show stats)
echo "Installing psutil.."
easy_install psutil
echo "Done"

# install i2cssh
echo "Installing i2cssh..."
gem install i2cssh
echo "Done"

echo "Done."
