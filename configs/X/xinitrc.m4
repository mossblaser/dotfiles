CONFIG_FILE(xinitrc, ~/.xinitrc)
# Used by startx to start a session.
gnome-settings-daemon &
nm-applet &
xcompmgr&
xhost local:root
xhost local:jonathan
xrdb ~/.Xresources

exec i3

