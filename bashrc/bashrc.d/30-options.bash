# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s checkwinsize
shopt -s cdspell
shopt -s cmdhist
shopt -s dirspell
shopt -s histappend
shopt -s globstar
shopt -s no_empty_cmd_completion

# man bash
unset HISTFILESIZE
export HISTSIZE=1000000
export HISTIGNORE="&:[bf]g:exit:ls:cd:cd ..:cd -"
# don't put duplicate lines in the history.
export HISTCONTROL=ignoredups:ignorespace
export HISTTIMEFORMAT='%F %T '

# https://www.gnu.org/software/bash/manual/html_node/Readline-Init-File-Syntax.html
bind 'set match-hidden-files off'
bind 'set completion-ignore-case on'
bind 'set completion-map-case on'
#bind 'set mark-modified-lines on'
bind 'set show-all-if-ambiguous on'
