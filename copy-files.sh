#!/usr/bin/env bash

SOURCE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )

TO_COPY=(
    .ackrc
    .bash
    .bash_aliases
    .bash_logout
    .bash_profile
    .bashrc
    .ctags
    .gitconfig
    .gitignore_global
    .inputrc
    .markdownlintrc
    .pam_environment
    .profile
    .screenrc
    .tmux.conf
    .vim
    .vimrc
    .wgetrc
    bin
)

SPECIAL=(
    .ssh/config
)

NUM=${#TO_COPY[@]}
echo "Hello ${USER},"
echo ""
echo "this script will copy (and overwrite) ${NUM} items from ${SOURCE_DIR} to ${HOME}."
echo ""
echo "Hint: use 'all' as a command line argument to copy files in non-interactive mode."
echo ""
read -p "Press enter or abort via CTRL+C..." pleaseimscared

if [[ $@ == *all* ]]
then
    rm -rf ${HOME}/.vim/bundle/*
fi

mkdir ${HOME}/.bash
mkdir ${HOME}/bin
mkdir ${HOME}/.npm-global
mkdir -p ${HOME}/.vim/{autoload,bundle,backup,swap,undo}

for (( i = 0 ; i < NUM ; i++ ))
do
    if [[ $@ == *all* ]]
    then
        cp -R ${SOURCE_DIR}/${TO_COPY[$i]} ${HOME}/
    else
        cp -iR ${SOURCE_DIR}/${TO_COPY[$i]} ${HOME}/
    fi
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
    #read -p "Press <enter> for next file..."
done

echo "See README.md for programs (linters) you might want to install."
echo ""
