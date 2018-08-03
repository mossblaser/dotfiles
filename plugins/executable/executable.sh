#!/bin/bash

# Give the named file executable permissions for the current user.
# Arguments:
#   - The file to give executable permissions
function make_file_executable() {
	chmod +x "$1"
}

add_m4_command "MAKE_FILE_EXECUTABLE" "make_file_executable"

