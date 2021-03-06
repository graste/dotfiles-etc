#!/usr/bin/env bash

set +x

CURRENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )

REPOS=(
    "ack.vim https://github.com/mileszs/ack.vim"
    "ctrlp.vim https://github.com/ctrlpvim/ctrlp.vim"
    "nerdcommenter https://github.com/scrooloose/nerdcommenter"
    "nerdtree https://github.com/scrooloose/nerdtree"
    "puppet-syntax-vim https://github.com/puppetlabs/puppet-syntax-vim"
    "vim-addon-mw-utils https://github.com/marcweber/vim-addon-mw-utils"
    "tlib_vim https://github.com/tomtom/tlib_vim"
    "vim-snipmate https://github.com/garbas/vim-snipmate"
    "syntastic https://github.com/scrooloose/syntastic"
    "tabular https://github.com/godlygeek/tabular"
    "textile.vim https://github.com/timcharper/textile.vim"
    "vim-haml https://github.com/tpope/vim-haml"
    "vim-markdown https://github.com/plasticboy/vim-markdown"
    "vim-php-namespace https://github.com/arnaud-lb/vim-php-namespace"
    "vim-repeat https://github.com/tpope/vim-repeat"
    "vim-surround https://github.com/tpope/vim-surround"
    "vim-twig https://github.com/qbbr/vim-twig"
    "vim-vertical-move https://github.com/bruno-/vim-vertical-move"
    "vim-php-refactoring-toolbox https://github.com/adoy/vim-php-refactoring-toolbox"
    "vim-json https://github.com/elzr/vim-json"
    "gundo.vim https://github.com/sjl/gundo.vim"
    "rust.vim https://github.com/rust-lang/rust.vim"
)

TEMP_DIR="$CURRENT_DIR/tmp"
mkdir -p "$TEMP_DIR" || exit 1

for folder in "${REPOS[@]}" ; do
    FOLDER=${folder%% *}
    URL=${folder#* }
    git clone --depth=1 $URL "$TEMP_DIR/$FOLDER" || exit 2
    rm -rf "$TEMP_DIR/$FOLDER/.git" || exit 3
    rm -rf "$CURRENT_DIR/$FOLDER" || exit 4
    cp -r "$TEMP_DIR/$FOLDER" "$CURRENT_DIR/" || exit 5
    rm -rf "$TEMP_DIR/$FOLDER" || exit 6
done
rm -rf $TEMP_DIR || exit 7
exit 0
