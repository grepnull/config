alias lt='ll -tr'
alias mod='lt | tail'
alias t='tail'
alias tf='tail -F'
alias grep='grep --color=auto --exclude "*.svn*"'
alias mi="make interactive"
alias svnu='svn up --ignore-externals'
function svns() {
   local dir=$1
   svn status --ignore-externals ${dir} | grep -v ^X
}
alias td='sudo tcpdump -A -s0 -i any port'
if [ $PAGER ]; then
    alias less=$PAGER
    alias zless=$PAGER
fi
alias e='emacsclient -t'
alias ip='/usr/local/share/python/ipython --colors LightBG'
function f () { find -L $@| grep -v \\.svn ; }

alias emacs=$EDITOR
alias d=docker
alias dm=docker-machine
alias dc=docker-compose
alias ds=docker-swarm

alias terraform=terragrunt

if command -v assh &> /dev/null; then
    alias ssh="assh wrapper ssh"
fi

if command -v ack-grep &> /dev/null; then
    # not on a mac
    alias ack=ack-grep
#    alias pbpaste='ssh 172.16.131.33 pbpaste'
#    alias pbcopy='ssh 172.16.131.33 pbcopy'
fi
