CONFIG_FILE(bash_aliases, ~/.bash_aliases)

alias c="clear"

alias t="tree"
alias ct="clear; tree"

# Clear out unwanted tempoary files
alias rmt='find \( -name "*.class" -o -name "*.pyc" -o -name "*~" -o -name "nohup.out" -o -name "*.o" -o -name "*.os" -o -name ".*.swo" \) -delete'

alias gs="git status"
alias gd="git diff --color=auto"

# Directory changing
function .. { cd ..; }
function - { cd -; }

alias ll='ls -l'
alias la='ls -A'

alias ka="killall -9"

ON_COMPUTER(USES_DEBIAN)
	alias ack="ack-grep"
END_COMPUTER()

# Don't bother me about downloads which have expired
alias get-iplayer="get-iplayer --nopurge"

# enable color support of various commands
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
