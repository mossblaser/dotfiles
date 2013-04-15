CONFIG_FILE(bash_profile, ~/.bash_profile)

ON_COMPUTER(LAPTOP)
PATH="/home/jonathan/bin/android-sdk-linux/tools:${PATH}"
PATH="/home/jonathan/bin/android-sdk-linux/platform-tools:${PATH}"
CLASSPATH="/home/jonathan/Programing/Java/:$CLASSPATH"

# New environment setting added by Sourcery G++ Lite for ARM EABI on Sat Dec 31 00:28:11 GMT 2011 1.
# The unmodified version of this file is saved in /home/jonathan/.bash_profile873164905.
# Do NOT modify these lines; they are used to uninstall.
PATH="/home/jonathan/bin/Sourcery_G++_Lite/bin:${PATH}"
export PATH
# End comments by InstallAnywhere on Sat Dec 31 00:28:11 GMT 2011 1.

export GOROOT="$HOME/bin/go"
export PATH="$PATH:$GOROOT/bin"
END_COMPUTER()

export PATH="$HOME/bin:$PATH"

ON_COMPUTER(PERSONAL)
[ -z "$DISPLAY" -a "$(tty)" = "/dev/tty1" ] && startx
END_COMPUTER()

