CONFIG_FILE(xsession, ~/.xsession)
# Used by lightdm to start a session.
gnome-settings-daemon &
nm-applet &
xcompmgr&
xhost local:root
xhost local:jonathan
xrdb ~/.Xresources

exec i3

