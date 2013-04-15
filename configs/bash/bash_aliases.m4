CONFIG_FILE(bash_aliases, ~/.bash_aliases)

alias c="clear"

alias t="tree"
alias ct="clear; tree"

alias s="scons"
alias sc="scons -c"

alias cs="clear;scons"
alias csc="clear;scons -c"

alias rmt='find \( -name "*.class" -o -name "*.pyc" -o -name "*~" -o -name "nohup.out" -o -name "*.o" -o -name "*.os" -o -name ".*.swo" \) -delete'
alias rms='find -name "*.swp" -delete'

alias gs="git status"
alias gd="git diff --color=auto"

function mcd { mkdir -p "$@" && cd "$@"; }
function .. { cd ..; }
function - { cd -; }

alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'

if ! which ack; then
	alias ack="ack-grep"
fi

alias k-9="killall -9"
alias ka9="killall -9"
alias k9="killall -9"
alias ka="killall -9"

alias gst-launch="gst-launch-0.10"

alias q=qalc

alias get-iplayer="get-iplayer --nopurge"
