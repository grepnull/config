### LL Environment ###
export WM_HOME=/opt/wm
export WMPROJECT_SCRIPT=~/Work/svn/project/build_ctrl/trunk/build_ctrl/bin/wm-project.py
export WORKSPACE_DIR=/Users/vince/Work/svn/project
export GIT_WORKSPACE=/Users/vince/Work/git
export WAVE_PLATFORM_VERSION=10.04-64
export WAVE_PLATFORM=ubuntu-10.04-64
export WAVE_PLATFORM_TYPE="ubuntu"
export BUILD_TOOLS_HOME=$GIT_WORKSPACE/common/build_tools
# Gradle #
export GRADLE_COMMON=$BUILD_TOOLS_HOME/gradle_common
export GRADLE_HOME="$(readlink -f /usr/local/bin/gradle)/../../.."
export GRADLE_OPTS="-Dorg.gradle.daemon=true"

### LL Aliases ###

alias wmproj='$WMPROJECT_SCRIPT -e -p ubuntu-10.04-64 --resolver=choosy -c $WORKSPACE_DIR --trylocal --nocache'
alias wmprojext='$WMPROJECT_SCRIPT -e -p ubuntu-10.04-64 --resolver=choosy -c $WORKSPACE_DIR --nocache'
alias gitproj='$WMPROJECT_SCRIPT -e -p ubuntu-10.04-64 --resolver=choosy -c $GIT_WORKSPACE -c $WORKSPACE_DIR --trylocal --nocache'
alias gitprojext='$WMPROJECT_SCRIPT -e -p ubuntu-10.04-64 --resolver=choosy -c $GIT_WORKSPACE --nocache'
alias projext="\`wmprojext ../project.xml\`"
alias proj="\`wmproj ../project.xml\`"
#alias gradle=$GRADLE_HOME/bin/gradle
alias fixoldgradle='ssh build@build \"rm .gradle/caches/0.9-preview-3/*/cache.bin\"'
function fixgradle() {
   ssh build@$1 "rm -rf /var/tmp/build/gradle/caches/"
}
alias fixl64build1='fixgradle l64build1'

if [ $(hostname) == 'vince' ]; then
    alias rt='sudo /etc/init.d/tomcat restart'
    alias fixssh='source $HOME/bin/fixssh'
    alias screen='grabssh; screen'
else
    alias rt='ssh root@vince /etc/init.d/tomcat restart'
fi

function go() {
    if [ -z $1 ]; then
        echo "Usage: go <repository> [branch]"
        echo "Refresh complete cache: go -r"
        return
    fi
    local repo=$1

    if [ $repo == '-r' ]; then
        rm -f /tmp/gitrepos
        echo "git clone completion cache reset"
        return
    fi

    local branch=""
    if [ ! -z $2 ]; then
        branch="-b $2"
    fi

    git clone $branch git@git.locationlabs.com:$repo --recursive
}

### LL Misc ###

if [ "$TERM" == 'screen' ] && [ $(hostname) == 'vince' ] ; then
    fixssh
fi

### LL Functions / Completions ###

function wm-project() {
    local spec=$1
    local origSpec=$spec
    local vers=$2

    local svnHome=$WORKSPACE_DIR
    local defaultToTrunk="false"

    if [ "$spec" == "${spec%:*}" ] && [ ! -f "$spec" ] ; then
        # spec is not in format "proj:ver" and is not a path to a file
        # try to find project.xml based on spec
        # star may match zero, one, or (in weird cases) more here. use
        # a for loop to be generally OK.
        echo $spec
        for potential in $svnHome/$origSpec/*_project/project.xml ; do
            if [ -f "$potential" ] ; then
                spec="$potential"
            fi
        done
        if [ ! -f $spec ] ; then
           spec="$svnHome/$origSpec/project.xml"
        fi
        if [ ! -f $spec ] ; then
           spec="$svnHome/$origSpec/branches/$vers.x/project.xml"
        fi
        if [ ! -f "$spec" ] ; then
           spec="$svnHome/$origSpec/trunk/project.xml"
           defaultToTrunk="true"
        fi
        if [ ! -f "$spec" ] ; then
           echo "Cannot find project.xml using spec $origSpec !!!"
           return 1
        fi
    fi

    if [ "$defaultToTrunk" == "true" ] ; then
        echo "Could only find project.xml by assuming trunk. If this isn't what you intended, please re-run."
    fi

    echo "Running: wmproj $spec > /tmp/wmproj.tmp"
    wmproj $spec > /tmp/wmproj.tmp
    cat /tmp/wmproj.tmp
    eval `cat /tmp/wmproj.tmp`
}

function git-project() {
    local spec=$1
    local origSpec=$spec
    local vers=$2

    local svnHome=$GIT_WORKSPACE
    local defaultToTrunk="false"

    if [ "$spec" == "${spec%:*}" ] && [ ! -f "$spec" ] ; then
        # spec is not in format "proj:ver" and is not a path to a file
        # try to find project.xml based on spec
        # star may match zero, one, or (in weird cases) more here. use
        # a for loop to be generally OK.
        echo $spec
        for potential in $svnHome/$origSpec/*_project/project.xml ; do
            if [ -f "$potential" ] ; then
                spec="$potential"
            fi
        done
        if [ ! -f $spec ] ; then
           spec="$svnHome/$origSpec/project.xml"
        fi
        if [ ! -f $spec ] ; then
           spec="$svnHome/$origSpec/branches/$vers.x/project.xml"
        fi
        if [ ! -f "$spec" ] ; then
           spec="$svnHome/$origSpec/trunk/project.xml"
           defaultToTrunk="true"
        fi
        if [ ! -f "$spec" ] ; then
           echo "Cannot find project.xml using spec $origSpec !!!"
           return 1
        fi
    fi

    if [ "$defaultToTrunk" == "true" ] ; then
        echo "Could only find project.xml by assuming trunk. If this isn't what you intended, please re-run."
    fi

    echo "Running: gitproj $spec > /tmp/gitproj.tmp"
    gitproj $spec > /tmp/gitproj.tmp
    cat /tmp/gitproj.tmp
    eval `cat /tmp/gitproj.tmp`
}

function _wm-project()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=`ls $WORKSPACE_DIR`

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _wm-project wm-project

function _git-project()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=`ls $GIT_WORKSPACE`

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _git-project git-project

function _git-repos()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    local gr=/tmp/gitrepos
    if [[ ! -e $gr || $(/usr/bin/find $gr -mtime +1d 2> /dev/null) ]]; then
        ssh -q git@git.locationlabs.com | grep "     R" | awk -v RS='\r' '{print $NF}' > $gr
    fi
    opts=`cat $gr`

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _git-repos go

# vince.engr.wm.com outputs the list of installed tomcat apps into dropbox
# every minute or so. This adds it into the bash completion to easily remotely
# reload them.
function _tomcat_apps()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=`cat ~/Dropbox/vince-webapps.txt`

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _tomcat_apps reload
