# Scratchpad

A Bash script that instantly sends focused window to a special workspace named
`scratchpad` and makes it easier to retrieve the window back to the current
workspace.

Usage:

To send the window to scratchpad

```ini
bind = SUPER, s, exec, scratchpad
```

To get back the window

```ini
bind = SUPERSHIFT, s, exec, scratchpad -g
```

use `-h` flag to get help.
