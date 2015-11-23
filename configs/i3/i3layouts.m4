i3 layout files/scripts for various layouts I use

--------------------------------------------------------------------------------
Google chrome command for different machines.
define(`CHROME',IF_COMPUTER(USES_ARCH,google-chrome-stable,google-chrome))
--------------------------------------------------------------------------------

CONFIG_FILE(Start up my mail client workspace, ~/.i3/layouts/mail.sh)
#!/bin/bash
i3-msg append_layout ~/.i3/layouts/mail.json
CHROME --app='http://gmail.com' &
CHROME --app='http://calendar.google.com' &
CHROME --app='http://mightytext.net/app' &

CONFIG_FILE(Layout for my email workspace., ~/.i3/layouts/mail.json)
{
    "type": "con",
    "layout": "tabbed",
    "nodes": [
        {
            "type": "con",
            "name": "Gmail",
            "swallows": [
               {
                  "class": "^google-chrome$",
                  "instance": "^gmail[.]com$"
               }
            ]
        },
        {
            "type": "con",
            "name": "Calendar",
            "swallows": [
               {
                  "class": "^google-chrome$",
                  "instance": "^calendar[.]google[.]com$"
               }
            ]
        },
        {
            "type": "con",
            "name": "MightyText",
            "swallows": [
               {
                  "class": "^google-chrome$",
                  "instance": "^mightytext[.]net__app$"
               }
            ]
        }
    ]
}


CONFIG_FILE(Start up my IM workspace, ~/.i3/layouts/im.sh)
#!/bin/bash
i3-msg append_layout ~/.i3/layouts/im.json
pidgin &
skype &

CONFIG_FILE(Layout for my IM workspace., ~/.i3/layouts/im.json)
{
    "type": "con",
    "layout": "splith",
    "nodes": [
        {
            // IM Clients/buddy lists
            "type": "con",
            "percent": 0.15,
            "layout": "tabbed",
            "nodes": [
                {
                    "type": "con",
                    "name": "Pidgin Buddy List",
                    "swallows": [
                         {
                            "class": "^Pidgin$",
                            "title": "^Buddy List$"
                         }
                    ]
                },
                {
                    "type": "con",
                    "name": "Hangouts",
                    "swallows": [
                         {
                            "class": "^google-chrome$",
                            "instance": "^crx_"
                         }
                    ]
                },
                {
                    "type": "con",
                    "name": "Skype",
                    "swallows": [
                         {
                            "class": "^Skype$",
                            "instance": "^skype$"
                         }
                    ]
                }
            ]
        },
        // Message windows
        {
            "type": "con",
            "percent": 0.85,
            "layout": "splith",
            "nodes": [
                // IRC Window (plus tabs for web-browser windows)
                {
                    "type": "con",
                    "percent": 0.5,
                    "layout": "tabbed",
                    "nodes": [
                        {
                            "type": "con",
                            "name": "#18sg",
                            "swallows": [
                                {
                                    "class": "^Pidgin$",
                                    "title": "^#18sg$"
                                }
                            ]
                        }
                    ]
                }
                // Other chat windows will open to the right...
            ]
        }
    ]
}


CONFIG_FILE(Start up my Music workspace, ~/.i3/layouts/music.sh)
#!/bin/bash
i3-msg append_layout ~/.i3/layouts/music.json
vlc &
CHROME --app='http://deezer.com' &
pavucontrol &
xterm -e bluetoothctl &


CONFIG_FILE(Layout for my Music workspace., ~/.i3/layouts/music.json)
{
    "type": "con",
    "layout": "splith",
    "nodes": [
        {
            // Media players
            "type": "con",
            "percent": 0.5,
            "layout": "tabbed",
            "nodes": [
                {
                    "type": "con",
                    "name": "VLC",
                    "swallows": [
                         {
                            "class": "^Vlc$"
                         }
                    ]
                },
                {
                    "type": "con",
                    "name": "Deezer",
                    "swallows": [
                         {
                            "class": "^google-chrome$",
                            "instance": "^deezer[.]com$"
                         }
                    ]
                }
            ]
        },
        // Volume control etc.
        {
            "type": "con",
            "percent": 0.5,
            "layout": "tabbed",
            "nodes": [
                // Volume control
                {
                    "type": "con",
                    "name": "Volume Control",
                    "swallows": [
                        {
                            "class": "^Pavucontrol$"
                        }
                    ]
                },
                {
                    "type": "con",
                    "name": "bluetoothctl",
                    "swallows": [
                        {
                            "title": "^bluetoothctl$"
                        }
                    ]
                }
            ]
        }
    ]
}


CONFIG_FILE(Start the GIMP with my window layout, ~/.i3/layouts/gimp.sh)
#!/bin/bash
i3-msg append_layout ~/.i3/layouts/gimp.json
gimp &


CONFIG_FILE(Layout GIMP., ~/.i3/layouts/gimp.json)
{
    "type": "con",
    "layout": "splith",
    "nodes": [
        {
            // Editor window
            "type": "con",
            "percent": 0.9,
            "layout": "tabbed",
            "nodes": [
                {
                    "type": "con",
                    "name": "Image Window",
                    "swallows": [
                         {
                            "class": "^Gimp$",
                            "window_role": "^gimp-image-window$"
                         }
                    ]
                }
            ]
        },
        // Pallete
        {
            "type": "con",
            "percent": 0.1,
            "name": "Toolbox",
            "swallows": [
                {
                    "class": "^Gimp$",
                    "window_role": "^gimp-toolbox$"
                }
            ]
        }
    ]
}


CONFIG_FILE(Start all the basic applications for a latex editing spree, ~/.i3/layouts/latex.sh)
#!/bin/bash
i3-msg append_layout ~/.i3/layouts/latex.json
xterm -name latexCompile &
gvim -name latexEditor &


CONFIG_FILE(Layout for latex editing, ~/.i3/layouts/latex.json)
{
    "type": "con",
    "layout": "splith",
    "nodes": [
        {
            // Compile/preview pane
            "type": "con",
            "percent": 0.4,
            "layout": "splitv",
            "nodes": [
                // PDF viewer
                {
                    "type": "con",
                    "name": "PDF Viewer",
                    "percent": 0.8,
                    "swallows": [
                         {
                            "class": "^Evince$"
                         }
                    ]
                },
                // Compile terminal (plus tabs for other terminals)
                {
                    "type": "con",
                    "layout": "tabbed",
                    "percent": 0.2,
                    "nodes": [
                        {
                            "type": "con",
                            "name": "xterm",
                            "swallows": [
                                 {
                                    "class": "^XTerm$",
                                    "instance": "^latexCompile$"
                                 }
                            ]
                        }
                    ]
                }
            ]
        },
        // Editor
        {
            "type": "con",
            "percent": 0.6,
            "layout": "tabbed",
            "nodes": [
                {
                    "type": "con",
                    "name": "GVim",
                    "swallows": [
                        {
                            "class": "^Gvim$",
                            "instance": "^latexEditor$"
                        }
                    ]
                }
            ]
        }
    ]
}
