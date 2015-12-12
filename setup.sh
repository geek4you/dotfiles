#!/usr/bin/env bash

BASE=~/.dotfiles

## run

echo "Downloading files.."
$BASE/download.sh

cd "$BASE"
git submodule update --init --recursive

echo "Linking..."

ln -sf $BASE/zshrc ~/.zshrc
#ln -sf $BASE/oh-my-zsh ~/.oh-my-zsh
ln -sf $BASE/bashrc ~/.bashrc
ln -sf $BASE/bash_profile ~/.bash_profile
ln -sf $BASE/bash_aliases ~/.bash_aliases
ln -sf $BASE/.profile ~/.profile
ln -sf $BASE/commonshrc ~/.commonshrc
ln -sf $BASE/inputrc ~/.inputrc
ln -sf $BASE/tmux/tmux.conf ~/.tmux.conf
ln -sf $BASE/vim ~/.vim
ln -sf $BASE/vimrc ~/.vimrc
ln -sf $BASE/zpreztorc ~/.zpreztorc
echo "Done."

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

echo "Done."
