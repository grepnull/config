export EDITOR='emacs -nw'
export TZ='US/Pacific'
# enable syntax highlighting for less
export LESS=' -R '
export PAGER=vimpager
export FIGNORE=\~:CVS:.svn

### Java ###
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home/
# Groovy on the mac defaults to MacRoman encoding
export JAVA_OPTS=-Dfile.encoding=UTF-8

if [ -e /usr/sbin/scutil ]; then
    export COMPUTER_NAME=$(/usr/sbin/scutil --get ComputerName)
fi
