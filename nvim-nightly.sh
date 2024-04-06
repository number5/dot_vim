#! /bin/zsh

#wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
MAC_ARM64_BINARY="nvim-macos-arm64.tar.gz"
gh release download -R neovim/neovim nightly -p "${MAC_ARM64_BINARY}" -D /tmp
cd
rm -rf ~/nvim-macos
tar xzvf /tmp/${MAC_ARM64_BINARY}
ln -sf ~/nvim-macos-arm64/bin/nvim ~/bin/nvim
