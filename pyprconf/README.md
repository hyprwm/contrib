# pyprconf

**templated configuration and event handling for Hyprland**

pyprconf is a front-end for Hyprland socket.sock and socket2.sock.
It is configured using a yaml file, and is intended to be exec'd in your
`hyprland.conf`.

## Installation

`python -m pip install .`

Modules will be installed to appropiate `site-packages` location, and a
command-line tool `pyprconf` in $HOME/.local/bin`.

### `hyprland.conf`

```
exec-once $HOME/.local/bin/pyprconf /path/to/conf.yaml
```