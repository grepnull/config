#!/bin/bash

# get referenced path of directory where this script is
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TO_LINK=$DIR/personal/*
BACKUP=~/.emacs.d/personal.backup.`date +%F_%H%M`
DEST=~/.emacs.d/personal

for l in $TO_LINK; do
    name=`basename $l`
    if [ -e $DEST/$name ]; then
        echo "Backing up $DEST/$name to $BACKUP"
        mkdir -p $BACKUP
        cp -R $DEST/$name $BACKUP
    fi
    echo "Linking $name";
    echo ""
    rm -rf ~/.$name;
    ln -sF $DIR/personal/$name $DEST/$name;
done
