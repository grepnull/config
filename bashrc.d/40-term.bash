case "$TERM" in
xterm*|rxvt*|screen*|linux*)

    256_color () {
        # http://en.wikipedia.org/wiki/File:Xterm_color_chart.png
        echo -ne "\[\033[38;5;$1m\]";
    }

    update_title() {
        # set the window title
        printf '\033]0;%s@%s: %s\007' "$USER" "$(hostname -s)" "${PWD/$HOME/~}"
    }
    update_prompt() {
        local NOCOLOR='\[\033[0m\]'
        local GREEN='\[\033[32m\]'
        local RED='\[\033[31m\]'
        local BOLD_RED='\[\033[01;31m\]'
        local WHITE_ON_RED='\[\033[01;41m\]'
        local BLUE='\[\033[01;34m\]'
        local CYAN='\[\033[37m\]'
        local PURPLE='\[\033[01;35m\]'
        local YELLOW='\[\033[33m\]'
        local WHITE_ON_GREY='\[\033[01;40m\]'
        local GREY_ON_GREY='\[\033[40m\]'

        local ORANGE=$(256_color 215)
        local INDIGO=$(256_color 164)
        local ROOTPREFIX=''
        if [ "$(whoami)" == "root" ]; then
            ROOTPREFIX="${WHITE_ON_RED}\u${NOCOLOR}@"
        fi

        local VE=''
        if [ $VIRTUAL_ENV ]; then
            VE="${INDIGO}<$(basename $VIRTUAL_ENV)>${NOCOLOR} "
        fi

        PS1="${VE}${ROOTPREFIX}${RED}\h${NOCOLOR}:${BLUE}\w${ORANGE}$(__git_ps1 " %s")${NOCOLOR}\$ "
    }
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
        # Only works with Apple's Terminal.app title bar proxy icons so far
        # taken from OS X's /etc/bashrc
        local SEARCH=' '
        local REPLACE='%20'
        local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
        printf '\e]7;%s\a' "$PWD_URL"
    }

    # __git_ps1 options
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWSTASHSTATE=true
    export GIT_PS1_SHOWUPSTREAM="git, verbose"

    PROMPT_COMMAND="update_terminal_cwd; update_title; update_prompt; $PROMPT_COMMAND"
    ;;
*)
    ;;
esac

# old function for getting git info. Now built into __git_ps1
#git_extra () {
#        # first check whether we're in a git repo at all
#    if ! git rev-parse --git-dir > /dev/null 2>&1; then
#	return 0
#    fi
#
#    local GIT_EXTRA=''
#
#        # any uncommitted changes?
#    if ! git diff --quiet 2>/dev/null >&2; then
#	GIT_EXTRA="${GIT_EXTRA} *"
#    fi
#
#    echo "$GIT_EXTRA"
#}
