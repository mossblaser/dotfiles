#!/bin/bash

# A plugin which allows binary files to be installed via conman.
#
# Usage: (in an m4 file)
#   INSTALL_BINARY(source, dest)
# Where source is a path relative to the m4 file and dest is a
# directory/filename on the system.

# Arguments:
#   1: source file relative to M4_FILE's directory
#   2: destination location/filename
function install_binary() {
	src="$1"
	dst="$2"
	
	cd "$(dirname "$M4_FILE")"
	
	# Make all directories if ending in a slash, otherwise just make those leading
	# to the name
	if echo "$dst" | grep -qE "/$"; then
		mkdir -p "$dst"
	else
		mkdir -p "$(dirname "$dst")"
	fi
	
	# Copy, preserving flags
	cp -a "$src" "$dst"
}

ENABLE_BINARIES=1
add_argument -B "ENABLE_BINARIES=0" "Disable copying of binary files"

add_m4_command "INSTALL_BINARY" "install_binary"
