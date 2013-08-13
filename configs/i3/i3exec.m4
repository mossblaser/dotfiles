--------------------------------------------------------------------------------
A macro which produces a line of shell to get the current workspace name.
define(GET_DESK,`i3-msg -t GET_WORKSPACES | jq -r "map(select(.focused == true)) | .[0][\"name\"]"')
--------------------------------------------------------------------------------
CONFIG_FILE(Sourceable script for setting workspace directories, ~/.i3/i3here)
# Source this (e.g. in bashrc) to provide here/there

function here() {
	# Store the current working directory for this desk
	PWD_FILE=~/.i3/here/"$(GET_DESK())"
	
	# Make sure the dir which stores the allocations exists!
	mkdir -p "$(dirname "$PWD_FILE")"
	
	# Put the current directory in a file named after this desk
	echo "cd \"$(pwd)\"" > "$PWD_FILE"
}

function there() {
	if [ -n "$1" ]; then
		# If a desk name is given, go to that desk's wd
		PWD_FILE="$(ls ~/.i3/here/"$1"* | head -n1)"
	else
		# Get this desk's wd
		PWD_FILE=~/.i3/here/"$(GET_DESK())"
	fi
	
	[ -f "$PWD_FILE" ] && source "$PWD_FILE"
}

CONFIG_FILE(Set the current working directory , ~/.i3/i3exec)
source ~/.i3/i3here
there
exec "$@"
