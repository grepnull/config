# make less more friendly for non-text input files, see lesspipe(1)
[ $(which lesspipe) ] && eval "$(lesspipe)"
[ $(which lesspipe.sh) ] && eval "$(lesspipe.sh)"

[ $(which brew) ] && BPREFIX=`brew --prefix`

function _bash_completion() {
    if [ -f $BPREFIX/etc/bash_completion ]; then
        . $BPREFIX/etc/bash_completion
    fi
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
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

export AUTOJUMP_KEEP_SYMLINKS=1
if [ -f $BPREFIX/etc/autojump.sh ]; then
    . $BPREFIX/etc/autojump.sh
fi
if [ -f /usr/share/autojump/autojump.sh ]; then
    . /usr/share/autojump/autojump.sh
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

function dock {
    if [ "$1" == "-h" ]; then
        echo "Usage: dock NAME [--swarm]"
        echo ""
        echo "NAME: name of docker-machine (Default: local)"
        echo "--swarm: machine is a swarm"
        return
    fi
    local MACHINE=${1:-local}
    echo "Switching to docker machine $MACHINE"
    eval $(docker-machine env $MACHINE $2)
}

function gradle {
    if [ -e ./gradlew ]; then
        echo "Using gradle wrapper..."
        ./gradlew $@
    else
        echo "Using global gradle..."
        /usr/local/bin/gradle $@
    fi
}

function git-clean-merged {
    if [ "$(git merged)" ]; then
        git merged
        read -p 'Delete these branches? ' -r
        if [ "$REPLY" == "y" ]; then
            git branch -d $(git merged)
        else
            echo 'Aborted.'
        fi
    else
        echo 'No merged branches to delete.';
    fi

    return 0
}

#export NVM_DIR=~/.nvm
#source $(brew --prefix nvm)/nvm.sh

# for awscli
complete -C aws_completer aws

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# github cli
if command -v hub &> /dev/null; then
    eval "$(hub alias -s)"
fi
