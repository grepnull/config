# make less more friendly for non-text input files, see lesspipe(1)
[ $(which lesspipe) ] && eval "$(lesspipe)"
[ $(which lesspipe.sh) ] && eval "$(lesspipe.sh)"

local BPREFIX='/usr/local'
[ $(which brew) ] && BPREFIX=`brew --prefix`

function _bash_completion() {
    if [ -f $BPREFIX/etc/bash_completion ]; then
        . $BPREFIX/etc/bash_completion
    fi
}
_bash_completion

_git_switch ()
{
    __gitcomp_nl "$(__git_refs '' 1)"
}

_git_sw ()
{
    __gitcomp_nl "$(__git_refs '' 1)"
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
elif [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    . /usr/local/bin/virtualenvwrapper.sh
fi

# http://pempek.net/articles/2013/04/24/vpn-less-persistent-ssh-sessions/
function rtmux {
    case "$2" in
        "") autossh -M 0 $1 -t "if tmux -qu has; then tmux -qu attach; else EDITOR=vim tmux -qu new; fi";;
        *) autossh -M 0 $1 -t "if tmux -qu has -t $2; then tmux -qu attach -t $2; else EDITOR=vim tmux -qu new -s $2; fi";;
    esac
}
