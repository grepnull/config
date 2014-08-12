if command -v emacsclient &> /dev/null; then
    export EDITOR='emacsclient -t -a emacs'
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

if [ $MAC_NAME ]; then
    ### Java on the Mac ###
    export JAVA_HOME=`/usr/libexec/java_home -v 1.6`
    # Groovy on the mac defaults to MacRoman encoding
    export JAVA_OPTS=-Dfile.encoding=UTF-8

    export HOMEBREW_TEMP=/var/tmp
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    export JYTHON_HOME=/usr/local/opt/jython/libexec/

    export DOCKER_HOST=tcp://localhost:2375
fi

export GOPATH=~/.go
export PEBBLE_PHONE=10.0.1.102
