git submodule update --init

sudo apt update
sudo apt install \
	ca-certificates \
	curl \
	gnupg \
	libncurses-dev \
	yacc \
	libevent-dev \
	pkg-config \
	gcc \
	automake \
	make


cd tmux
./autogen.sh
./configure
sudo make install

cd ../fzf
./install

cd ../vim
./configure \
	--enable-multibyte \
	--enable-rubyinterp=yes \
	--enable-perlinterp=yes  \
	--enable-python3interp=yes \
	--enable-luainterp=yes
make -j
sudo make install
cd ..

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --remove-all vi
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

cp -r .* ~

vim +PluginInstall +qall


# installing nodejs for vim-coc
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_21.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install nodejs

# finishing coc installation
cd ~/.vim/bundle/coc.nvim
npm ci
