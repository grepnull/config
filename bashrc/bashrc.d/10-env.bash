export EDITOR='vi'
if command -v emacsclient &> /dev/null; then
    export EDITOR='emacsclient -t -a vi'
elif command -v emacs &> /dev/null; then
    export EDITOR='emacs -nw'
fi

# export TZ='US/Pacific'
# enable syntax highlighting for less
export LESS=' -R '

if command -v vimpager &> /dev/null; then
    export PAGER=vimpager
fi

export FIGNORE=\~:CVS:.svn

# If we're on a Mac, get the mac's name as set in System Preferences->Sharing->Computer Name
# can also use to detect if we're on a mac at all. If MAC_NAME is set then this is a mac
if [ -e /usr/sbin/scutil ]; then
    export MAC_NAME=$(/usr/sbin/scutil --get ComputerName)
fi

if [ "${MAC_NAME}" ]; then
    ### Java on the Mac ###
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
    # Groovy on the mac defaults to MacRoman encoding
    export JAVA_OPTS=-Dfile.encoding=UTF-8

    export HOMEBREW_TEMP=/var/tmp
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    export JYTHON_HOME=/usr/local/opt/jython/libexec/

    if command -v ant; then
        export ANT_HOME=`dirname $(dirname $(greadlink -f $(which ant)))`
    fi

    export HOMEBREW_GITHUB_API_TOKEN=e4e924568100ea79e1d3e2ee6fe0f69f9ad91b30

    export ITERM_PANE_INDEX=$(($(echo $ITERM_SESSION_ID | sed -e "s/^.*p\(.*\):.*/\1/") - 1))
    export ITI=$ITERM_PANE_INDEX
fi

export ACK_OPTIONS="--ignore-dir=.eggs --ignore-dir=.tox"

# enable colors in `ls`
export CLICOLOR=1 # for macs
export LS_COLOR=auto # linux

export GOPATH=~/.go
append_path $GOPATH/bin

export MOSH_TITLE_NOPREFIX=1

# disable ctrl-s/ctrl-q nonsense
stty -ixon
