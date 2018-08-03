CONFIG_FILE(dmenu-powered window list, ~/.i3/i3nextfreeworkspace)
#!/bin/bash
MAKE_FILE_EXECUTABLE(~/.i3/i3nextfreeworkspace)
# Switch to the next available workspace
# Usage:
#     ./i3nextfreeworkspace 
# switches to the next free workspace
#     ./i3nextfreeworkspace move
# moves the current container to the next free workspace

NEXT_FREE_WORKSPACE="$(
	diff -c0 <(i3-msg -t GET_WORKSPACES \
	           | jq '.[] | .num' \
	           | sort -n) \
	         <(seq 10) \
	| sed -nre 's/^[+] (.*)$/\1/p' \
	| head -n1
)"
[ -z "$NEXT_FREE_WORKSPACE" ] && echo "No free workspaces">&2 && exit 1

if [ "$1" == "move" ]; then
	i3-msg "move container to workspace $NEXT_FREE_WORKSPACE; workspace $NEXT_FREE_WORKSPACE"
else
	i3-msg "workspace $NEXT_FREE_WORKSPACE"
fi
