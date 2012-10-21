alias ls='ls -G'
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
alias less=$PAGER
alias zless=$PAGER
alias e='emacs -nw'
alias ipython='ipython --colors LightBG'
function f () { find -L $@| grep -v \\.svn ; }
