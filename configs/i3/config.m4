--------------------------------------------------------------------------------
M4 Macro Loop constructs for the more repetative commands:

define(`forloop',
       `pushdef(`$1', `$2')_forloop(`$1', `$2', `$3', `$4')popdef(`$1')')
define(`_forloop',
       `$4`'ifelse($1, `$3', ,
       `define(`$1', incr($1))_forloop(`$1', `$2', `$3', `$4')')')
--------------------------------------------------------------------------------
M4 Macro "WRAPEXEC()" expands to the exec wrapper used to launch interactive
programs

define(`WRAPEXEC',`~/.i3/i3exec')
--------------------------------------------------------------------------------
M4 Macro to define program launchers
define(`PROGRAM',`bindsym $launcher_mod+$1 exec WRAPEXEC() $2')
--------------------------------------------------------------------------------



CONFIG_FILE(i3 Window Manager, ~/.i3/config)

################################################################################
# Global Defines
################################################################################

# Use Windows key for modifiers for launching things
set $launcher_mod Mod4

# Use the Alt key as the modifier for WM functions
set $mod Mod1

# Rate at which floating windows are moved per step
set $float_move_rate 25

# Rate at which tiling windows are resized per step (% points)
set $tile_resize_rate 5

# Rate at which floating windows are resized per step (pixels)
set $float_resize_rate 25

# Ratfloat_e at which floating windows are moved per step
set $float_move_rate 25

# Names for each workspace
set $ws_1   1
set $ws_2   2
set $ws_3   3
set $ws_4   4
set $ws_5   5
set $ws_6   6
set $ws_7   7
set $ws_8   8
set $ws_9   9: Mail
set $ws_10 10: IM


################################################################################
# Auto-start
################################################################################

# Start the compositing manager
exec --no-startup-id xcompmgr


################################################################################
# Program launchers
################################################################################

# General launcher
PROGRAM(space, dmenu_run)

# Terminals
PROGRAM(t,xterm)
PROGRAM(q,xterm qalc)
PROGRAM(y,xterm -e python -i ~/.pythonrc)
PROGRAM(l,xterm gnuplot)
PROGRAM(m,xterm maxima)

# Utilities
PROGRAM(e, gvim)
PROGRAM(w, google-chrome)
PROGRAM(f, nautilus --no-desktop)

# Graphics
PROGRAM(g, gimp)
PROGRAM(i, inkscape)

# IM
PROGRAM(p, pidgin)

# Media
PROGRAM(r, rhythmbox)


################################################################################
# Workspaces
################################################################################

# Automatic workspace placements
assign [class="^Pidgin$"] $ws_10
assign [class="^Skype$"]  $ws_10


################################################################################
# Font
################################################################################

ON_COMPUTER(PERSONAL)
font pango:Monaco 7
ELSE_COMPUTER()
font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
END_COMPUTER()


################################################################################
# Window Borders & Colours
################################################################################

# The window border used for tiling and floating windows
#   normal [num] = Window border and title bar
#   1pixel       = literally just a single pixel border (no title/resize)
#   none         = No borders at all
#   pixel [num]  = No window title but resize bars present
new_window normal
new_float  normal

# Hide window borders at the left-and-right edoges of the display
hide_edge_borders vertical

# Tango-based Colour Scheme
# class                 border  backgr. text    indicator
client.focused          #3465a4 #285577 #eeeeec #729fcf
client.focused_inactive #555753 #2e3436 #babdb6 #484e50
client.unfocused        #2e3436 #2e3436 #babdb6 #292d2e
client.urgent           #fcaf3e #f57900 #eeeeec #fcaf3e

# Background of windows which are transparent
client.background #000000

# When switching to a desk with an urgency hint, wait this long before clearing
# it on focus.
force_display_urgency_hint 1000 ms


################################################################################
# Floating Window Handling
################################################################################

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# Constraint floating window sizes so there won't be any so small they can't be
# seen...
floating_minimum_size 75 x 50
floating_maximum_size -1 x -1

# Toggle floating/tiling mode
bindsym $mod+shift+t floating toggle


################################################################################
# Tiling Layout Handling
################################################################################

# By default, orient a workspace based on whether the screen is horizontal or
# vertical.
default_orientation auto

# Workspaces should have tiled layout (rather than stacking or tabbed) by
# default.
workspace_layout default

# When moving focus in a direction off the end of a tab/stack, don't wrap around
# to the start of the tabs/stack unless at the edge of the screen.
force_focus_wrapping no

# Keys to change the layout of the current container
# d = down
# f = forward
# s = stacking
# a = ...tabbed?
bindsym $mod+a layout tabbed
bindsym $mod+s layout stacking
bindsym $mod+d layout splitv
bindsym $mod+f layout splith


################################################################################
# Fullscreen
################################################################################

# Display the popup window immediately only if it belongs to the fullscreen'd
# window
popup_during_fullscreen smart

bindsym $mod+Return fullscreen


################################################################################
# Window Navigation and Movement
################################################################################

# Create a container around the currently focused window (keys are one row below
# their corresponding layout changing ones)
bindsym $mod+z split horizontal; layout tabbed
bindsym $mod+x split horizontal; layout stacking
bindsym $mod+c split vertical
bindsym $mod+v split horizontal

# Directional focus navigation commands (vim + arrow versions)
bindsym $mod+h     focus left
bindsym $mod+Left  focus left
bindsym $mod+l     focus right
bindsym $mod+Right focus right
bindsym $mod+k     focus up
bindsym $mod+Up    focus up
bindsym $mod+j     focus down
bindsym $mod+Down  focus down

# Toggle between floating and tiling window layers
bindsym $mod+t focus mode_toggle

# Directional movement commands (vim + arrow versions)
bindsym $mod+shift+h     move left  $float_move_rate px
bindsym $mod+shift+Left  move left  $float_move_rate px
bindsym $mod+shift+l     move right $float_move_rate px
bindsym $mod+shift+Right move right $float_move_rate px
bindsym $mod+shift+k     move up    $float_move_rate px
bindsym $mod+shift+Up    move up    $float_move_rate px
bindsym $mod+shift+j     move down  $float_move_rate px
bindsym $mod+shift+Down  move down  $float_move_rate px

# Tree traversal
bindsym $mod+bracketleft  focus parent
bindsym $mod+bracketright focus child

################################################################################
# Multiple Display Navigation and Movement
################################################################################

# Output focus movement
# < and > = left and right
# ; and / = up and down
bindcode $mod+59 focus output left
bindcode $mod+60 focus output right
bindcode $mod+47 focus output up
bindcode $mod+61 focus output down

# Output container movement
bindcode $mod+shift+59 move container to output left;   focus output left
bindcode $mod+shift+60 move container to output right;  focus output right
bindcode $mod+shift+47 move container to output up;     focus output up
bindcode $mod+shift+61 move container to output down;   focus output down

# Output workspace movement
bindcode $mod+ctrl+shift+59 move workspace to output left;   focus output left
bindcode $mod+ctrl+shift+60 move workspace to output right;  focus output right
bindcode $mod+ctrl+shift+47 move workspace to output up;     focus output up
bindcode $mod+ctrl+shift+61 move workspace to output down;   focus output down


################################################################################
# Workspace navigation and movement
################################################################################

# Workspace navigation
forloop(`i', 1, 10, `
	# Switch to workspace i
	bindsym $mod+eval(i%10) workspace $ws_`'i
	
	# Move focused container to workspace i and move there
	bindsym $mod+shift+eval(i%10) move container to workspace $ws_`'i;  workspace $ws_`'i
')


################################################################################
# Resize
################################################################################

mode "resize" {
	# These bindings trigger as soon as you enter the resize mode
	
	# Shrink/grow width
	bindsym h     resize shrink width $float_resize_rate px or $tile_resize_rate ppt
	bindsym Left  resize shrink width $float_resize_rate px or $tile_resize_rate ppt
	bindsym l     resize grow   width $float_resize_rate px or $tile_resize_rate ppt
	bindsym Right resize grow   width $float_resize_rate px or $tile_resize_rate ppt
	
	# Shrink/grow height
	bindsym j    resize shrink height $float_resize_rate px or $tile_resize_rate ppt
	bindsym Up   resize shrink height $float_resize_rate px or $tile_resize_rate ppt
	bindsym k    resize grow   height $float_resize_rate px or $tile_resize_rate ppt
	bindsym Down resize grow   height $float_resize_rate px or $tile_resize_rate ppt
	
	# Resize to absolute percentages using the num keys
	forloop(`i', 1, 9, `
		bindsym i exec --no-startup-id python ~/.i3/i3resize.py i`'0
	')
	
	# back to normal: Enter or Escape
	bindsym Return     mode "default"
	bindsym Escape     mode "default"
	bindsym $mod+space mode "default"
}

# Enter resize mode
bindsym $mod+space mode "resize"


################################################################################
# Marks
################################################################################

# Allow the user to specify a single-char mark for a window
bindsym $mod+m exec i3-input -l 1 -F 'mark %s' -P 'Set Mark: '

# Allow the user to switch to a single-char marked window
bindsym $mod+grave exec i3-input -l 1 -F '[con_mark="%s"] focus' -P 'Focus Mark: '


################################################################################
# i3bar Config
################################################################################

bar {
	# TODO: Make my own magic status line
	# status_command i3status --config ~/.i3/i3status.conf
	
	# Use i3's standard status line generator
	status_command i3status
	
	# Always visible
	mode dock
	
	# Bottom of screen
	position bottom
	
	# Always show the system tray on the primary display
	tray_output primary
	
	# Show the workspace buttons
	workspace_buttons yes
	
	# Tango-based colour scheme
	colors {
		background #2e3436
		statusline #eeeeec
		separator  #babdb6
		
		# class            border  bg      text
		focused_workspace  #729fcf #285577 #eeeeec
		active_workspace   #888a85 #555753 #eeeeec
		inactive_workspace #888a85 #2e3436 #babdb6
		urgent_workspace   #fcaf3e #f57900 #eeeeec
	}
}


################################################################################
# Closing Windows
################################################################################

# Kill the current window gracefully
bindsym $mod+F4 kill





################################################################################
# Exit/Restart
################################################################################

# Bodge: use a mode to confirm reset
mode "Press enter to exit" {
	bindsym Enter exit
	bindsym Escape mode "default"
	bindsym $mod+Escape mode "default"
}
bindsym $mod+Escape mode "Press enter to exit"


# Restart i3 in-place
bindsym $mod+shift+r restart

# Reload i3 config file
bindsym $mod+r reload