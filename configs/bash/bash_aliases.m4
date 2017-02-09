CONFIG_FILE(bash_aliases, ~/.bash_aliases)

alias c="clear"

alias t="tree"
alias ct="clear; tree"

# Clear out unwanted tempoary files
alias rmt='find \( -name "*.class" -o -name "*.pyc" -o -name "*~" -o -name "nohup.out" -o -name "*.o" -o -name "*.os" -o -name ".*.swo" \) -delete'

alias gs="git status"
alias gd="git diff --color"

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

# Add local node binary path
function np {
	BASE_DIR="$PWD"
	while [ ! -d "$BASE_DIR/node_modules/.bin" ]; do
		BASE_DIR="$(realpath "$BASE_DIR/..")"
		[ "$BASE_DIR" = "/" ] && break
	done
	
	NODE_BIN_DIR="$BASE_DIR/node_modules/.bin" 
	
	if [ -d "$NODE_BIN_DIR" ]; then
		export PATH="$PATH:$NODE_BIN_DIR"
	else
		echo "np: ERROR: No node_modules directory found!"
		return 1
	fi
}
