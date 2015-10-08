CONFIG_FILE(i3 Absolute Percentage Resize Util, ~/.i3/i3resize.py)
#!/usr/bin/env python

"""
Set the absolute size of a window in i3.

	# Set the currently focused window to 50% of its parent container's size
	python i3resize.py 50
"""

from pprint import pprint

import i3ipc

SPLIT_LAYOUTS = "splith splitv".split()

def get_resizeables(target):
	"""
	Returns a tuple (parent, child) where parent and child are i3ipc
	containers. Child is either the currently focused window or the highest
	most nesting of tabbed/stacked/singleton containers which eventually
	contain the focused window. Parent is the immediate parent of the child
	container and will have a split layout.
	
	@param target The node to be resiezd.
	"""
	# Work our way up the tree past all non-split layouts and any split layouts
	# with singletons in.
	child = target
	while (child.parent.layout not in SPLIT_LAYOUTS
	       or len(child.parent.nodes) == 1):
		child = child.parent
	
	return child.parent, child


def set_size(conn, container, size):
	"""
	Set the size (as a percentage of its parent's size) of the container whose
	tree is given as container.
	"""
	parent, child = get_resizeables(container)
	
	# Decide which dimension to resize along
	dimension = {
		"splith": "width",
		"splitv": "height",
	}[parent.layout]
	
	# Work out the current size
	cur_size = (getattr(child.rect, dimension)*100) / getattr(parent.rect, dimension)
	
	# Work out whether to grow or shrink
	grow_shrink = "grow" if cur_size < size else "shrink"
	
	conn.command("[con_id=%d] resize %s %s 0 px or %d ppt"%(
		child.id, grow_shrink, dimension, abs(cur_size - size)))


if __name__=="__main__":
	import sys
	conn = i3ipc.Connection()
	set_size(conn, conn.get_tree().find_focused(), int(sys.argv[1]))
