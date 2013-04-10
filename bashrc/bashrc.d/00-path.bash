function append_path() {
    local value=$1
    local var=${2:-PATH}

    if [ ! -d $1 ]; then
        return;
    fi

    for part in `echo ${!var} | tr ':' ' '`; do
        if [ "$part" = $value ]; then
            return;
        fi
    done

    if [ -z "${!var}" ]; then
        export ${var}=${value}
    else
        export ${var}=${!var}:${value}
    fi
}

function prepend_path() {
    local value=$1
    local var=${2:-PATH}

    if [ ! -d $1 ]; then
        return;
    fi

    # remove from path if already existing
    local newpath=''
    for part in `echo ${!var} | tr ':' ' '`; do
        if [ "$part" != $value ]; then
            if [ -z "${newpath}" ]; then
                newpath=${part}
            else
                newpath=${newpath}:${part}
            fi
        fi
    done
    export ${var}=${newpath}

    # prepend to path
    if [ -z "${!var}" ]; then
        export ${var}=${value}
    else
        export ${var}=${value}:${!var}
    fi
}

append_path /usr/share/man MANPATH
append_path /usr/man MANPATH
append_path /usr/local/man MANPATH
append_path /usr/local/share/man MANPATH
append_path /usr/kerberos/man MANPATH

append_path ~/bin PATH
append_path ~/Work/bin PATH
append_path ~/Documents/bin PATH
append_path /usr/bin PATH
append_path /usr/local/opt/ruby/bin PATH
append_path /usr/local/share/python PATH

prepend_path /usr/local/bin PATH
prepend_path /usr/local/sbin PATH
prepend_path /opt/alternatives/bin PATH
if [ $GRADLE_HOME ]; then
    prepend_path $GRADLE_HOME/bin PATH
fi
