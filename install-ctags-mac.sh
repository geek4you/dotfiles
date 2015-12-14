BASE=~/.dotfiles
cd $BASE
wget http://surfnet.dl.sourceforge.net/sourceforge/ctags/ctags-5.7.tar.gz
tar -xvzf ctags-5.7.tar.gz
cd ctags-5.7/
./configure
make
sudo make install
