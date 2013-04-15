CONFIG_FILE(yalu menu, ~/.yalu/menu, USES_YALU)
File Browser {7412369}	nohup gnome-open "$PWD"&
x&clock {3214789}

&Qalc	xterm qalc
P&ython	xterm -e python -i ~/.pythonrc
GnuP&lot	xterm gnuplot
&Maxima	xterm maxima

&Inkscape	inkscape
&GIMP	gimp

&Skype	skype
&Pidgin	pidgin

&Rhythmbox	rhythmbox
ON_COMPUTER(PERSONAL)

Shelf We&b	ssh shelf@shelf "export DISPLAY=\"0:0\"; chromium $(xclip -o)"
Room &Headphone Toggle {1474569}	bash /home/jonathan/bin/headphone_toggle.sh
END_COMPUTER()
