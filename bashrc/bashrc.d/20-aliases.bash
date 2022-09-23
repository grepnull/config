alias lt='ll -tr'
alias mod='lt | tail'
alias t='tail'
alias tf='terraform'
alias tfw='terraform workspace show'
alias tfwl='terraform workspace list'
alias tfws='terraform workspace select'
alias tfwn='terraform workspace new'
alias grep='grep --color=auto --exclude "*.svn*"'
alias mi="make interactive"
alias svnu='svn up --ignore-externals'
alias wo='workon $(basename $PWD)'

# Avoid printing lines that are super long (e.g. minified JS)
# that will overwhelm terminals with scrolling texts for a long time.
alias ag='ag -W300'

function svns() {
   local dir=$1
   svn status --ignore-externals ${dir} | grep -v ^X
}
alias td='sudo tcpdump -A -s0 -i any port'
if [ $PAGER ]; then
    alias less=$PAGER
    alias zless=$PAGER
fi
alias e='emacs'

#alias emacs=$EDITOR
alias d=docker
alias dm=docker-machine
alias dc=docker-compose
alias ds=docker-swarm

if command -v assh &> /dev/null; then
    alias ssh="$(which assh) wrapper ssh"
fi

if command -v ack-grep &> /dev/null; then
    # not on a mac
    alias ack=ack-grep
#    alias pbpaste='ssh 172.16.131.33 pbpaste'
#    alias pbcopy='ssh 172.16.131.33 pbcopy'
fi
alias https='http --default-scheme=https'
