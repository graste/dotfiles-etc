#!/bin/bash

# $(dirname ${BASH_SOURCE[0]})
# DOTFILES_DIR=$(dirname "$0")

if [ -L $0 ] ; then
    ME=$(readlink $0)
else
    ME=$0
fi

DOTFILES_DIR=$(dirname $ME)
SOURCE_DIR=$(pwd -P $DOTFILES_DIR)

FILES=(
    .ackrc
    .bash
    .bash_aliases
    .bash_logout
    .bash_profile
    .bashrc
    .inputrc
    .profile
    .screenrc
    .vimrc
    .gitignore
    .gitconfig
)

SPECIAL=(
    .ssh/config
)

NUM=${#FILES[@]}
echo "Hello ${USER},"
echo ""
echo "this script will copy (and overwrite) ${NUM} items from ${SOURCE_DIR} to ${HOME}."
echo ""
read -p "Press enter or abort via CTRL+C..." pleaseimscared
mkdir ${HOME}/.bash
mkdir -p ${HOME}/.vim/{backup,swap,undo}
for (( i = 0 ; i < NUM ; i++ ))
do
    cp -iR ${SOURCE_DIR}/${FILES[$i]} ${HOME}/
done

NUM=${#SPECIAL[@]}
for (( i = 0 ; i < NUM ; i++ ))
do
    echo "File ${SOURCE_DIR}/${SPECIAL[$i]} with content:"
    echo "-----------------------------------------------"
    cat ${SOURCE_DIR}/${SPECIAL[$i]}
    echo "-----------------------------------------------"
    echo "If you need this file, you should copy the file (or it's content) via:"
    echo "cp -iR ${SOURCE_DIR}/${SPECIAL[$i]} ${HOME}/"
    echo ""
    read -p "Press <enter> for next file..."
done

