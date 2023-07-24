#! /bin/zsh

#wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
gh release download -R neovim/neovim nightly -p "*macos.tar.gz" -D /tmp
cd
rm -rf ~/nvim-macos
tar xzvf /tmp/nvim-macos.tar.gz
ln -sf ~/nvim-macos/bin/nvim ~/bin/nvim
