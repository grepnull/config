# make less more friendly for non-text input files, see lesspipe(1)
[ $(which lesspipe) ] && eval "$(lesspipe)"
[ $(which lesspipe.sh) ] && eval "$(lesspipe.sh)"

function _bash_completion() {
    # The ones in /etc/bash_completion.d
    # (on 14.04 at least) are not compatible.
    # Do not source them.
    # You will get errors like 'have: command not found'
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    fi
    if [ -f $HOMEBREW_PREFIX/etc/bash_completion ]; then
        . $HOMEBREW_PREFIX/etc/bash_completion
    fi
    if [[ -d $HOMEBREW_PREFIX/etc/bash_completion.d ]]; then
        for f in $HOMEBREW_PREFIX/etc/bash_completion.d/* ; do
            source "$f"
        done;
    fi
}
_bash_completion

export AUTOJUMP_KEEP_SYMLINKS=1
if [ -f $HOMEBREW_PREFIX/etc/autojump.sh ]; then
    . $HOMEBREW_PREFIX/etc/autojump.sh
fi

if command -v virtualenvwrapper.sh > /dev/null; then
    . $(which virtualenvwrapper.sh)
fi


# https://cirw.in/blog/bracketed-paste
# If you start seeing pasted content wrapped with 0~ and 1~ , you need to
# disable bracketed paste mode
function enable-bracketed-paste-mode {
    printf '\e[?2004h'
}
function disable-bracketed-paste-mode {
    printf '\e[?2004l'
}

#export NVM_DIR=~/.nvm
#source $(brew --prefix nvm)/nvm.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# for awscli
complete -C aws_completer aws

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# github cli
if command -v hub &> /dev/null; then
    eval "$(hub alias -s)"
fi

# pyenv
if command -v pyenv > /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"

    eval "$(pyenv init --path)"
fi

# terraform
complete -C $(which terraform) terraform tf
