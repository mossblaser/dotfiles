CONFIG_FILE(i3 Status-bar Config, ~/.i3/i3status.conf)

general {
	output_format = "i3bar"
	interval = 5
	
	colors = true
	color_good     = "#8ae234"
	color_degraded = "#fce94f"
	color_bad      = "#ef2929"
}

order += "ethernet eth0"
order += "wireless wlan0"
order += "battery 0"
order += "load"
order += "time"

ethernet eth0 {
	format_up   = " E: %ip "
	format_down = " E: down "
}

wireless wlan0 {
	format_up   = " W: %ip (%essid) "
	format_down = " W: down "
}

battery 0 {
	format = " %status %percentage %remaining "
	last_full_capacity = true
}

load {
	format = " %5min "
}

time {
	format = " %d-%m-%Y %I:%M %P "
}
