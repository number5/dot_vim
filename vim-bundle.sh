#!/bin/zsh
set extendedglob

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
for url in $(cat $_BUNDLE_FILE); do
    echo $url
    cd $_BUNDLE_DIR
    git clone $url
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



