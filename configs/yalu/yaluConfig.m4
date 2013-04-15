IF_COMPUTER(USES_YALU, `GIT_REPO(~/.yalu, git@github.com:mossblaser/YALU.git)')
CONFIG_FILE(yaluConfig, ~/.yalu/yaluConfig, USES_YALU)

SetEnv yaluBrowser "google-chrome"

SetEnv yaluDesks "2"

SetEnv yaluDeskWidth "3"

SetEnv yaluDeskHeight "3"

Key Print A N Exec "/home/jonathan/bin/desklight_toggle.sh"
Key Insert A N Exec "/home/jonathan/bin/roomlight_toggle.sh"

Key KP_Prior A N Exec "/home/jonathan/bin/vol_inc.sh"
Key KP_Home A N Exec "/home/jonathan/bin/vol_dec.sh"
Key KP_Up A N Exec "bash /home/jonathan/bin/headphone_toggle.sh"

setEnv yaluEdgeJumpWidth "100"

SetEnv yaluEdgeJumpHeight "100"

