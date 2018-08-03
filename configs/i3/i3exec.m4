--------------------------------------------------------------------------------
A macro which produces a line of shell to get the current workspace name.
define(GET_WS_PROP,`i3-msg -t GET_WORKSPACES | jq -r "map(select(.focused == true)) | .[0][\"$1\"]"')
--------------------------------------------------------------------------------
CONFIG_FILE(Sourceable script for setting workspace directories, ~/.i3/i3here)
#!/bin/bash
MAKE_FILE_EXECUTABLE(~/.i3/i3here)
# Source this (e.g. in bashrc) to provide here/there

function here() {
	# Given a name as an argument, use that instead of the directory name
	I3_WS_NAME="$1"
	
	# Store the current working directory for this desk
	PWD_FILE=~/.i3/here/"$(GET_WS_PROP(num))"
	
	# Make sure the dir which stores the allocations exists!
	mkdir -p "$(dirname "$PWD_FILE")"
	
	# Put the current directory in a file named after this desk
	echo "cd \"$(pwd)\"" > "$PWD_FILE"
	echo "I3_WS_NAME=\"$I3_WS_NAME\"" >> "$PWD_FILE"
	
	# If in a virtual-env, reactivate that automatically
	if [ -n "$VIRTUAL_ENV" ]; then
		ACTIVATE_FILE="$VIRTUAL_ENV/bin/activate" 
		echo "[ -f \"$ACTIVATE_FILE\" ] && source \"$ACTIVATE_FILE\"" >> "$PWD_FILE"
	fi
	
	# If any node_modules directories are in the path, re-add them later
	NODE_PATH="$(echo "$PATH" | tr ":" "\n" | grep "/node_modules/.bin" | tr "\n" ":")"
	if [ -n "$NODE_PATH" ]; then
		echo "export PATH=\"\$PATH:$NODE_PATH\"" >> "$PWD_FILE"
	fi
	
	# Set the workspace name
	~/.i3/i3nameworkspace
}

function there() {
	if [ -n "$1" ]; then
		# If a desk name is given, go to that desk's wd
		PWD_FILE="$(ls ~/.i3/here/"$1"* | head -n1)"
	else
		# Get this desk's wd
		PWD_FILE=~/.i3/here/"$(GET_WS_PROP(num))"
	fi
	
	[ -f "$PWD_FILE" ] && source "$PWD_FILE"
}

CONFIG_FILE(Just a file version of the "here" command, ~/.i3/here_cmd)
#!/bin/bash
MAKE_FILE_EXECUTABLE(~/.i3/here_cmd)
source ~/.i3/i3here
here "$@"

CONFIG_FILE(Set the current working directory , ~/.i3/i3exec)
#!/bin/bash
MAKE_FILE_EXECUTABLE(~/.i3/i3exec)
source ~/.i3/i3here
there
exec "$@"

CONFIG_FILE(Rename the current workspace based on the here directory, ~/.i3/i3nameworkspace)
#!/bin/bash
MAKE_FILE_EXECUTABLE(~/.i3/i3nameworkspace)
# Move into the current directory

# This sleep gives i3 time to actually complete the workspace switch (it
# sometimes happens too late resulting in this command renaming the old
# workspace or worse.
sleep 0.05

source ~/.i3/i3here
there

WORKSPACE_OLD_NAME="$(GET_WS_PROP(name))"
WORKSPACE_NUMBER="$(GET_WS_PROP(num))"

if [ -n "$I3_WS_NAME" ]; then
	WORKSPACE_NAME="$WORKSPACE_NUMBER: $I3_WS_NAME"
else
	# Convert to tilde-led version (so $HOME is just ~ not a username)
	WORKING_DIR="$PWD"
	[[ "$WORKING_DIR" =~ ^"$HOME"(/|$) ]] && WORKING_DIR="~${WORKING_DIR#$HOME}"
	
	WORKSPACE_NAME="$WORKSPACE_NUMBER: $(basename "$WORKING_DIR")"
fi

if [ "$WORKSPACE_OLD_NAME" != "$WORKSPACE_NAME" ]; then
	i3-msg "rename workspace \"$WORKSPACE_OLD_NAME\" to \"$WORKSPACE_NAME\"" > /dev/null
fi
