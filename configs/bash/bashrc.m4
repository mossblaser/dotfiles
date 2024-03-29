CONFIG_FILE(bashrc, ~/.bashrc)

# Get our bash profile on SSH shells
export BASHRC_LOADED="yes"
[ -z "$BASH_PROFILE_LOADED" ] && . $HOME/.bash_profile

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Try and enable colour support
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    . ~/bin/fancyprompt
else
    PS1='\u@\h:\w£ '
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

ON_COMPUTER(USES_DEBIAN|USES_UBUNTU)
# Use Magic Debian bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
END_COMPUTER()
ON_COMPUTER(USES_ARCH)
# Use magic Arch bash completion
if [ -r /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
fi
END_COMPUTER()

ON_COMPUTER(PERSONAL)
export PYTHONSTARTUP=~/.pythonrc
END_COMPUTER()

ON_COMPUTER(PERSONAL)
# SHET Support
export SHET_HOST="127.0.0.1"
#export SHET_HTTP_URL="http://18sg.net:8080/"
. shet_complete 2>/dev/null

# Qth support
export QTH_HOST=server
END_COMPUTER()

ON_COMPUTER(BBCRD)
. "$HOME/bin/cans_auth_functions.sh"
END_COMPUTER()

# Here/There For i3
. ~/.i3/i3here

# Auto-complete for terraform
complete -C /usr/bin/terraform terraform
