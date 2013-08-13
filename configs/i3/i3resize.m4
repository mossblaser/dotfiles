CONFIG_FILE(i3 Absolute Percentage Resize Util, ~/.i3/i3resize.py)
#!/usr/bin/env python

"""
Set the absolute size of a window in i3.

As a library::
	
	# Set the currently focused window to 50% of its parent container's size
	import i3, i3resize
	i3resize.set_size(i3.filter(focused=True)[0], 50)

As a standalone:
	
	# Set the currently focused window to 50% of its parent container's size
	python i3resize.py 50
"""

from pprint import pprint

import i3

class NoResizeableException(Exception):
	pass

class NoTargetWindow(NoResizeableException):
	"""
	No window matches the target window.
	"""
	pass

class NoSplitParent(NoResizeableException):
	"""
	No split-container is a parent of the focused window.
	"""
	pass


SPLIT_LAYOUTS = "splith splitv".split()

def get_resizeables(target, root = None, split = None):
	"""
	Returns a tuple (parent, child) where parent and child are i3 trees. Child is
	either the currently focused window or the top-level container of a nesting of
	tabbed/stacked containers which eventually contain the focused window. Parent
	is the immediate parent of the child container and will have a split layout.
	
	If no such layout exists, raises an exception inhereted from
	NoResizeableException.
	
	@param root  The tree to work on or None to use the current i3 tree
	@param split The last split container encountered (internal use only)
	"""
	root = root or i3.get_tree()
	
	if root["id"] != target["id"]:
		# If this is a split container, set split
		if root["layout"] in SPLIT_LAYOUTS:
			split = root
		
		# This window isn't the target, try the children
		for child in root["nodes"]:
			try:
				return get_resizeables(target, child, split)
			except NoTargetWindow:
				# Might be in another child
				pass
		# No child contained the target window, die!
		raise NoTargetWindow("No containers matched the target.")
	else:
		# We've reached the target window!
		if split is None:
			# But we didn't find a split parent to resize within
			raise NoSplitParent("The current container is not in a split container.")
		else:
			# Find the child of the split container which contains the target window
			for child in split["nodes"]:
				if i3.filter(tree = child, id = root["id"]):
					# All done!
					return split, child
			
			assert False, "split should always be a parent of root!"


def set_size(container, size):
	"""
	Set the size (as a percentage of its parent's size) of the container whose
	tree is given as container.
	"""
	parent, child = get_resizeables(container)
	
	# Decide which dimension to resize along
	dimension = {
		"splith": "width",
		"splitv": "height",
	}[parent["layout"]]
	
	# Work out the current size
	cur_size = (child["rect"][dimension]*100) / parent["rect"][dimension]

	# Work out whether to grow or shrink
	grow_shrink = "grow" if cur_size < size else "shrink"
	
	i3.resize(grow_shrink, dimension, "0", "px", "or", str(abs(cur_size - size)), "ppt")


if __name__=="__main__":
	import sys
	set_size(i3.filter(focused=True)[0], int(sys.argv[1]))
