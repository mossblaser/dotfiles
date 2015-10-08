CONFIG_FILE(Lazily load programs on a workspace, ~/.i3/i3wslaunch.py)
#!/usr/bin/env python

"""
Run an i3 command (typically exec) when a workspace is created for the first
time.

Usage examples::
	
	# Run top in an xterm when switching to an empty workspace number 6.
	python i3wslaunch.py -N 6 "exec xterm top"
	
	# Run IM client when switching to IM desktop
	python i3wslaunch.py -n "IM" "exec pidgin"
"""

import signal
import sys
import time

import i3ipc

def main(command, name = None, number = None):
	"""
	Function which runs forever and runs a command everytime a desk with the
	given name or number is focused while empty (i.e. opened for the first time).
	"""
	
	conn = i3ipc.Connection()
	
	# Create a callback to do the deed
	def on_ws_change(conn, event):
		# Only for the matching workspace
		if name == event.current.name or number == event.current.num:
			# Only if the workspace is fresh/empty
			if event.current.nodes == []:
				# Run command
				conn.command(command)
	
	# Start watching for workspace changes
	conn.on("workspace::focus", on_ws_change)
	conn.main()



if __name__=="__main__":
	from argparse import ArgumentParser
	parser = ArgumentParser()
	parser.add_argument("-n", "--name", dest="name",
	                    help="Full name of workspace to monitor.")
	parser.add_argument("-N", "--number", dest="number", type=int,
	                    help="Full name of workspace number to monitor.")
	parser.add_argument("command", nargs="+",
	                    help="The command to execute.")
	
	args = parser.parse_args()
	
	name   = args.name
	number = args.number
	i3_command = " ".join(args.command)
	
	main(i3_command, name, number)
