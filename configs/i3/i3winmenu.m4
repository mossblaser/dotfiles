CONFIG_FILE(dmenu-powered window list, ~/.i3/i3winmenu.py)
#!/usr/bin/env python
# dmenu script to jump to windows in i3.
#
# using ziberna's i3-py library: https://github.com/ziberna/i3-py
# depends: dmenu (vertical patch), i3.
# released by joepd under WTFPLv2-license:
# http://sam.zoy.org/wtfpl/COPYING
#
# edited by Jure Ziberna for i3-py's examples section

import i3ipc
import subprocess
import collections

def i3clients(conn):
    """
    Returns a dictionary of key-value pairs of a window text and window id.
    Each window text is of format "[workspace] window title (instance number)"
    """
    clients = collections.OrderedDict()
    windows = conn.get_tree().leaves()
    for window in sorted(windows, key=(lambda w: w.workspace().name)):
        clients["[%s] %s (%d)"%(window.workspace().name,
                                window.name,
                                window.id)] = window.id
    return clients

def win_menu(clients, l=10):
    """
    Displays a window menu using dmenu. Returns window id.
    """
    dmenu = subprocess.Popen(['/usr/bin/dmenu','-i','-l', str(l)],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE)
    menu_str = '\n'.join(clients)
    # Popen.communicate returns a tuple stdout, stderr
    win_str = dmenu.communicate(menu_str.encode('utf-8'))[0].decode('utf-8').rstrip()
    return clients.get(win_str, None)

if __name__ == '__main__':
    conn = i3ipc.Connection()
    clients = i3clients(conn)
    win_id = win_menu(clients)
    if win_id:
        conn.command("[con_id=%d] focus"%(win_id))
