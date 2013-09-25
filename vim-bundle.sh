#!/bin/zsh
setopt extendedglob

_BUNDLE_DIR="$HOME/.vim/bundle"
_BUNDLE_FILE="$HOME/.vim/bundlerc"

update() {
  for d in $_BUNDLE_DIR/*; do
      echo $d
      cd $d
      [ -d .git ] && git pull
      #[ -d .hg ] && hg pull -u
  done
}

show() {
    for d in $_BUNDLE_DIR/*; do
        cd $d
        [ -d .git ] && git config --get remote.origin.url
    done 
}

checkout() {
mkdir -p $_BUNDLE_DIR 
mkdir -p $HOME/src/git
for url in $(cat $_BUNDLE_FILE); do
    echo $url
    cd $HOME/src/git
    git clone $url
    repo=${${url##*/}%.*}
    ln -sf $HOME/src/git/$repo $_BUNDLE_DIR/$repo
done
}

case "$1" in
  show) 
    show | sort;;
  update)
    update;;
  checkout)
    checkout;;
  *)
    show | sort;;
esac



