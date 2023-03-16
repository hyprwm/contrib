hyprprop(1)

# NAME

hyprprop - A replacement for xprop within hyprland

# SYNOPSIS

*hyprprop* [--help] [--check] [--id id] [--raw]

# OPTIONS

*--help*
	Show command help

*--check*
	Check dependencies are installed

*--id id*
	Skip selecting a window, get information for given ID

*--raw*
	Output raw JSON data

# DESCRIPTION

Hyprprop is a interactive window information utility, based on grimblast.
It allows you to view properties hyprland knows about a window you click.

# EXAMPLES

An example of using hyprprop
```
$ hyprprop
{
  "address": "0x1d0503e0",
  "mapped": true,
  "hidden": false,
  "at": [
    1063,
    1140
  ],
  "size": [
    835,
    492
  ],
  "workspace": {
    "id": 6,
    "name": "6"
  },
  "floating": false,
  "monitor": 0,
  "class": "Alacritty",
  "title": "Alacritty",
  "pid": 57833,
  "xwayland": false,
  "pinned": false,
  "fullscreen": false,
  "fullscreenMode": 0,
  "fakeFullscreen": false,
  "grouped": [],
  "swallowing": null
}
```

# OUTPUT

Hyprprop will output formatted JSON returned from hyprctl about the selected window.

# SEE ALSO

*xprop*(1)
