# shellevents

Invoke shell functions in response to Hyprland socket2 events.

## Description

`shellevents` reads Hyprland events from stdin as documented in the [Hyprland Wiki](http://wiki.hyprland.org/IPC/#tmphyprhissocket2sock). Please read [Events list](https://wiki.hyprland.org/IPC/#events-list) to understand what each event means. Also, see `shellevents_default.sh` for the supported function names.

## Prerequisites

We'll use `socat` to connect to Hyprland socket2, so make sure you have `socat` installed.

## Getting Started

`submaps.sh` and `notifywindow.sh` are two included examples. In this guide we'll use `notifywindow.sh`.

1. Run `shellevents` with `notifywindow.sh`:

```bash
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock EXEC:"/path/to/shellevents /path/to/notifywindow.sh",nofork
```

2. Open your browser of choice with reddit.com, and you should see the notification. It needs to be reddit.com when you open your browser.

## How to use

1. `shellevents_default.sh` is the events reference. We'll generate a `custom_event_file.sh`:

```bash
cp /path/to/shellevents_default.sh /path/to/custom_event_file.sh
```

2. In `custom_event_file.sh`, add your custom handlers for the events you want to handle.

Note: The comment inside each handler shows the variables that are set when the handler is invoked.

```bash
event_openwindow() {
  : # WINDOWADDRESS WORKSPACENAME WINDOWCLASS WINDOWTITLE
}
```

3. Run the following command:

```bash
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock EXEC:"/path/to/shellevents /path/to/custom_event_file.sh",nofork
```

## Tips

1. If you have made changes, reload `custom_event_file.sh`:

```bash
killall shellevents -USR1
```

2. Simply add the above `socat` to `exec-once` to run `shellevents` during Hyprland startup.

3. To help debugging, enable `verbose` output by passing `-v` as the first argument to `shellevents`. It'll print all events to `stderr` to help debugging.
