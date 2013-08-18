CONFIG_FILE(bash_profile, ~/.bash_profile)

ON_COMPUTER(THINKPAD)
CLASSPATH="/home/jonathan/Programing/Java/:$CLASSPATH"
END_COMPUTER()

# We want everything in bin
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/bin/scripts" ] && export PATH="$HOME/bin/scripts:$PATH"

# We want conman to be in the path
[ -d "$HOME/.dotfiles" ] && export PATH="$HOME/.dotfiles:$PATH"

# We want jhnet to be in the path
[ -d "$HOME/Programing/Web/Jhnet13/util" ] && export PATH="$HOME/Programing/Web/Jhnet13/util:$PATH"

# Default programs
EDITOR="vim"
VISUAL="vim"
PAGER="less"
if [ -n "$DISPLAY" ]; then
	BROWSER=google-chrome
else
	BROWSER=elinks
fi

ON_COMPUTER(THINKPAD)
# Auto-start the graphical session on login
#[ -z "$DISPLAY" -a "$(tty)" = "/dev/tty1" ] && startx
END_COMPUTER()
