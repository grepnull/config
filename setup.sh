#!/bin/bash

# get referenced path of directory where this script is
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TO_LINK="bash_profile bashrc bashrc.d"

for l in $TO_LINK; do echo "Linking $l"; rm -f ~/.$l; ln -sF $DIR/$l ~/.$l; done
