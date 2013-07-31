CONFIG_FILE(fancyprompt, ~/bin/fancyprompt)
#!/usr/bin/bash

RESET="\[\033[000m\]"
RED="\[\033[000;031m\]"

function colour_code_user_machine {
	case "$USER" in
		"jonathan") USER_COLOUR=6;;
		"heathcj9") USER_COLOUR=2;;
		"root")     USER_COLOUR=1;;
		*)          USER_COLOUR=0;;
	esac
	
	case "$HOSTNAME" in
		jonathan*)   MACHINE_COLOUR=6;;
		+(lf|gfpc)*) MACHINE_COLOUR=2;;
		"soba")      MACHINE_COLOUR=3;;
		"server")    MACHINE_COLOUR=1;;
		*)           MACHINE_COLOUR=0;;
	esac
	
	echo -ne "\[\033[04"
	echo -ne "$USER_COLOUR"
	echo -ne ";03"
	echo -ne "$MACHINE_COLOUR"
	echo -ne "m\]"
}


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


function contract_path {
	TRUNCATE="…"
	wd="$(pwd \
	      | sed -re "s:$HOME(.*):~\1:" \
	      | sed -re "s:~/Programing/[^/]+/(.*):$TRUNCATE\1:" \
	     )"
	echo -n "$wd"
}


function psown_my_ps {
	export last_exit="$?"
	
	user_machine="$(colour_code_user_machine "$USER" "$HOSTNAME")▄$RESET"
	working_dir="$(contract_path "$(pwd)")"
	status_block="$(make_status_block)"
	
	export PS1="$user_machine $working_dir $status_block "
	#export PS1="$working_dir% "
	
	export FRESH_TERM=""
}

export FRESH_TERM="yes"
export PROMPT_COMMAND="psown_my_ps"
