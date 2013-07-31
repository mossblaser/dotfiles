CONFIG_FILE(bashrc, ~/.bashrc)

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

ON_COMPUTER(USES_DEBIAN)
# Use Magic Debian bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
END_COMPUTER()

ON_COMPUTER(PERSONAL)
export PYTHONSTARTUP=~/.pythonrc
END_COMPUTER()

ON_COMPUTER(PERSONAL)
# SHET Support
export SHET_HOST="shelf"
#export SHET_HTTP_URL="http://18sg.net:8080/"
. shet_complete
END_COMPUTER()

