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

# We want the maple toolchain to be inthe path
[ -d "$HOME/Programing/libmaple/arm/bin" ] && export PATH="$HOME/Programing/libmaple/arm/bin:$PATH"
[ -d "$HOME/Programing/libmaple" ] && export LIB_MAPLE_HOME="$HOME/Programing/libmaple"

ON_COMPUTER(UNI_TEACHING | UNI_RESEARCH)
# Various libraries installed the hard way in uni need to be in the path
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/bin/libconfig/lib:$HOME/bin/check/lib"
export CPPFLAGS="$CPPFLAGS -I$HOME/bin/check/include -I$HOME/bin/libconfig/include"
export LDFLAGS="$LDFLAGS -L$HOME/bin/check/lib -L$HOME/bin/libconfig/lib"
export PKG_CONFIG_PATH="PKG_CONFIG_PATH:$HOME/bin/libconfig/lib/pkgconfig"
END_COMPUTER()

# Speedy/debugable defaults for CFLAGS
export CFLAGS="$CFLAGS -g -O3"

# Default programs
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
if [ -n "$DISPLAY" ]; then
	export BROWSER=google-chrome
else
	export BROWSER=elinks
fi

# Also get our bashrc on login shells.
export BASH_PROFILE_LOADED="yes"
[ -z "$BASHRC_LOADED" ] && . $HOME/.bashrc

ON_COMPUTER(THINKPAD)
# Auto-start the graphical session on login
#[ -z "$DISPLAY" -a "$(tty)" = "/dev/tty1" ] && startx
END_COMPUTER()
