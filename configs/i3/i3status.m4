--------------------------------------------------------------------------------
Define the network interfaces
define(`ETHERNET',_first_)
define(`WIRELESS',_first_)
--------------------------------------------------------------------------------

CONFIG_FILE(i3 Status-bar Config, ~/.i3/i3status.conf)

general {
	output_format = "i3bar"
	interval = 5
	
	colors = true
	color_good     = "#8ae234"
	color_degraded = "#fce94f"
	color_bad      = "#ef2929"
}

order += "ethernet ETHERNET"
order += "wireless WIRELESS"
ON_COMPUTER(HAS_TWO_BATTERIES)
order += "battery 1"
END_COMPUTER()
order += "battery 0"
order += "load"
order += "time"

ethernet ETHERNET {
	format_up   = " E: %ip "
	format_down = " E: down "
}

wireless WIRELESS {
	format_up   = " W: %ip (%essid) "
	format_down = " W: down "
}

ON_COMPUTER(HAS_TWO_BATTERIES)
battery 1 {
	format = " Ext: %status %percentage %remaining "
	last_full_capacity = true
}
END_COMPUTER()

battery 0 {
	format = " IF_COMPUTER(HAS_TWO_BATTERIES,`Int: ',`')%status %percentage %remaining "
	last_full_capacity = true
}

load {
	format = " %5min "
}

time {
	format = " %d-%m-%Y %I:%M %P "
}
