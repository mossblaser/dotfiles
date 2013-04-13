#!/bin/bash

# Clone (and update) a git repo.
# Arguments:
#   - The path to clone to.
#   - The repository url.
function update_git_repo() {
	(($ENABLE_GIT)) || return
	
	path="$1"
	remote="$2"
	mkdir -p "$path"
	(
		cd "$path"
		git init -q
		git pull "$remote"
	)
}

ENABLE_GIT=1
add_argument -g "ENABLE_GIT=0" "Disable updating of git repositories."

add_m4_command "GIT_REPO" "update_git_repo"
