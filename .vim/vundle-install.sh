#! /usr/bin/env bash

VUNDLE=~/.vim/bundle/vundle

if [[ ! -d $VUNDLE ]]; then
    mkdir -p `dirname $VUNDLE`
    git clone http://github.com/gmarik/vundle.git $VUNDLE
fi

vim -u `dirname $0`/bundles.vim +BundleInstall +q

