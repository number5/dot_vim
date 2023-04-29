#! /bin/zsh

cd /tmp
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
cd
rm -rf ~/nvim-macos
tar xzvf /tmp/nvim-macos.tar.gz
ln -sf ~/nvim-macos/bin/nvim ~/bin/nvim
