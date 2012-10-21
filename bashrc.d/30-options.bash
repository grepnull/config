# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s cdspell

shopt -s histappend
shopt -s cmdhist

unset HISTFILESIZE
export HISTSIZE=1000000
export HISTIGNORE="&:[bf]g:exit"
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

bind 'set match-hidden-files off'
