sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
 libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
 libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
 python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev checkinstall \
 cscope


cd vim

# you need to choose between python3.5 / 2.7
	#--enable-pythoninterp=yes \
./configure \
	--enable-multibyte \
	--enable-rubyinterp=yes \
	--enable-perlinterp=yes  \
	--enable-python3interp=yes \
	--enable-luainterp=yes \
	--enable-cscope

sudo checkinstall -y

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

vim +PluginInstall +qall
