# make less more friendly for non-text input files, see lesspipe(1)
[ $(which lesspipe) ] && eval "$(lesspipe)"
[ $(which lesspipe.sh) ] && eval "$(lesspipe.sh)"

BPREFIX=''
[ $(which brew) ] && BPREFIX=`brew --prefix`

if [ -f $BPREFIX/etc/bash_completion ]; then
    . $BPREFIX/etc/bash_completion
fi

_git_switch ()
{
    __gitcomp_nl "$(__git_refs)"
}

_git_sw ()
{
    __gitcomp_nl "$(__git_refs)"
}

_switch ()
{
    COMPREPLY=( $(compgen -W "$(__git_refs)" -- ${cur}) )
    return 0
}

complete -F _switch switch

if [ -f $BPREFIX/etc/autojump.bash ]; then
    . $BPREFIX/etc/autojump.bash
fi

if [ -f $BPREFIX/share/python/virtualenvwrapper.sh ]; then
    . $BPREFIX/share/python/virtualenvwrapper.sh
fi
