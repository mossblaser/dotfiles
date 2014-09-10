CONFIG_FILE(fancyprompt, ~/bin/fancyprompt)
#!/bin/bash

# Colour codes
RESET="\[\033[000m\]"
RED="\[\033[000;031m\]"

# Work out the colour code for this machine/account combo
function colour_code_user_machine {
	case "$USER" in
		"jonathan") USER_COLOUR=6;;
		"heathcj9") USER_COLOUR=2;;
		"mbax9jh2") USER_COLOUR=3;;
		"root")     USER_COLOUR=1;;
		*)          USER_COLOUR=0;;
	esac
	
	case "$HOSTNAME" in
		jonathan*)        MACHINE_COLOUR=6;;
		kilburn|E-C07KI*) MACHINE_COLOUR=3;;
		rs0*)             MACHINE_COLOUR=2;;
		*)                MACHINE_COLOUR=0;;
	esac
	
	echo -ne "\[\033[04"
	echo -ne "$USER_COLOUR"
	echo -ne ";03"
	echo -ne "$MACHINE_COLOUR"
	echo -ne "m\]"
}


# Show the term
function make_status_block {
	if [ -n "$DISPLAY" ]; then
		FRESH="►"
		FAIL="▲"
		NORM="▶"
	else
		FRESH="▻"
		FAIL="△"
		NORM="▷"
	fi
	
	if [ "$last_exit" != "0" ]; then
		echo -ne "$RED$FAIL$RESET"
	elif [ -n "$FRESH_TERM" ]; then
		echo -ne "$FRESH"
	else
		echo -ne "$NORM"
	fi
}

# Contract "obvious" paths
function contract_path {
	TRUNCATE="..."
	wd="$(pwd \
	      | sed -re "s:$HOME(.*):~\1:" \
	      | sed -re "s:~/Programing/[^/]+/(.*):$TRUNCATE\1:" \
	     )"
	echo -n "$wd"
}


# Change the prompt (at the last moment!) to show last command success etc. and
# also set window title
function psown_my_ps {
	export last_exit="$?"
	
	user_machine="$(colour_code_user_machine "$USER" "$HOSTNAME")▄$RESET"
	working_dir="$(contract_path "$(pwd)")"
	status_block="$(make_status_block)"
	
	export PS1="$user_machine $working_dir $status_block "
	#export PS1="$working_dir% "
	
	export FRESH_TERM=""
	
	# Set window title to reflect path when not running a command
	if [ -z "$MANUAL_TITLE" ]; then
		set_title "$(contract_path "PWD")"
	fi
}


# Automatically set the title based on the requested command
function auto_title {
	# If no title has been specified manually and its not the prompt update
	# function. Also, don't title fresh terminals.
	if [ -z "$MANUAL_TITLE" -a "$BASH_COMMAND" != "psown_my_ps" -a -z "$FRESH_TERM" ]; then
		set_title "$BASH_COMMAND"
	fi
}


# Set the XTERM window title
function set_title {
	echo -ne "\e]2;$1\a"
}


# User-facing override window title function
function title {
	export MANUAL_TITLE="$*"
	set_title "$*"
}

export MANUAL_TITLE=""
export FRESH_TERM="yes"
export PROMPT_COMMAND="psown_my_ps"

# Causes auto_title to be run before every command
trap auto_title DEBUG
