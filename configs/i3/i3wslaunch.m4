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

import i3

def when_workspace_created(callback, name = None, number = None):
	"""
	Function which runs forever and calls callback everytime a desk with the given
	name or number is focused while empty (i.e. opened for the first time).
	"""
	
	# Create a callback to do the deed
	def my_function(event, data, subscription):
		# Only on switch to workspace
		if event["change"] == "focus":
			# Only for the matching workspace
			if (name is not None and event["current"]["name"] == name) or \
			   (number is not None and event["current"]["num"] == number):
				# Only if the workspace is fresh/empty
				if event["current"]["nodes"] == []:
					# Run callback
					callback()
	
	# Start watching for workspace changes
	subscription = i3.Subscription(my_function, 'workspace')
	
	# Close the subscription when killed
	def on_int(signal, frame):
		subscription.close()
		sys.exit(0)
	signal.signal(signal.SIGINT, on_int)
	
	# Nothing else to do in the main thread (subscription is processed in another
	# thread)
	signal.pause()



if __name__=="__main__":
	from optparse import OptionParser
	parser = OptionParser()
	parser.add_option("-n", "--name", dest="name",
	                  help="Full name of workspace to monitor.")
	parser.add_option("-N", "--number", dest="number", type="int",
	                  help="Full name of workspace number to monitor.")
	
	(options, args) = parser.parse_args()
	
	name   = options.name
	number = options.number
	i3_command = " ".join(args)
	
	def callback():
		time.sleep(0.5)
		i3.command(i3_command)
	
	when_workspace_created(callback, name, number)
