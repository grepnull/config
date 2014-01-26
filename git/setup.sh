#!/bin/bash

# get referenced path of directory where this script is
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TO_LINK="$DIR/gitconfig $DIR/gitignore_global"
BACKUP=~/.git.backup.`date +%F_%H%M`
DEST=~

for l in $TO_LINK; do
    name=`basename $l`
    dotname=.$name
    if [ -e $DEST/$dotname ]; then
        echo "Backing up $DEST/$dotname to $BACKUP/$name"
        mkdir -p $BACKUP
        cp $DEST/$dotname $BACKUP/$name
    fi
    echo "Linking $name";
    echo ""
    rm ~/$dotname;
    ln -sF $DIR/$name $DEST/$dotname;
done
