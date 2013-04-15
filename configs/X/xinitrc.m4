CONFIG_FILE(xinitrc, ~/.xinitrc)

# dbus-y goodness
source /etc/X11/xinit/xinitrc

(
	sleep 1
	ck-launch-session dbus-launch gnome-settings-daemon &
	ck-launch-session dbus-launch nm-applet &
	xcompmgr&
	xhost local:root
	xhost local:jonathan
) &

exec ck-launch-session dbus-launch fvwm2 -f ~/.yalu/fvwmConfig

