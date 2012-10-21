# make less more friendly for non-text input files, see lesspipe(1)
[ $(which lesspipe) ] && eval "$(lesspipe)"
[ $(which lesspipe.sh) ] && eval "$(lesspipe.sh)"

BPREFIX=''
[ $(which brew) ] && BPREFIX=`brew --prefix`

if [ -f $BPREFIX/etc/bash_completion ]; then
    . $BPREFIX/etc/bash_completion
fi

if [ -f $BPREFIX/etc/autojump ]; then
    . $BPREFIX/etc/autojump
fi

if [ -f $BPREFIX/share/python/virtualenvwrapper.sh ]; then
    . $BPREFIX/share/python/virtualenvwrapper.sh
fi
