# Changelog

### 2025-03-31

shellevents: support minimized event

### 2025-03-16

grimblast: use '--batch' for 'hyprctl' to limit the number of control calls

### 2025-03-15

grimblast: remove moveCursorPosition and restoreCursorPosition for OUTPUT and duplicate jq command

### 2025-03-10

grimblast: Fix erroneous error notification caused by bash syntax error

### 2025-03-08

grimblast: add check for HYPRLAND_INSANCE_SIGNATURE to avoid confusing errors when the tool is ran in other WMs

### 2025-03-03

grimblast: add environment var `GRIMBLAST_HIDE_CURSOR` to avoid high CPU loads on some machines

### 2025-03-01

grimblast: hide the grim cursor before taking a screenshot

### 2025-03-01

hdrop: 0.6.0 -> 0.7.6\
Fix for new syntax of `hyprctl dispatch` from hyprland 0.46.2 onwards\
Limit `--online` to 20sec\
Fix `--online` for cases in which it is called multiple times spaced apart in time\
Fix manpage\
Make `--online` behaviour consistent when there is no network connection at all and when there is just no internet connection\
Fix behaviour of `--floating` on multi-monitor setups with differing resolutions

### 2025-02-13

grimblast: disallow using --cursor with `area` selection

### 2025-02-10

grimblast: fix --notify not showing

### 2025-01-24

grimblast: allow decimals for --wait

### 2025-01-21

grimblast: allow opening file directory when clicking on notification when --openfile is set

### 2024-12-01

grimblast: fix window selection on fullscreen

### 2024-11-04

grimblast: use layerrules instead of modifying animations

### 2024-10-17

shellevents: support windowtitlev2 event

### 2024-09-05

hdrop: add `--focus` option

### 2024-09-01

hdrop:
   - add class replacement for epiphany and godot
   - refactor
   - cleanup
   - add recognition of `--app-id` for foot
   - disable error notifications when closing foot

### 2024-08-02

grimblast: changed method to check if another instance is running

### 2024-07-10

grimblast: recognize windows of special workspaces

### 2024-06-16

shellevents: add README.md

### 2024-05-13

hdrop: fix Nix package license

### 2024-04-22

scratchpad: add gawk to closure

### 2024-04-07

grimblast: add hyprpicker to closure

### 2024-03-21

grimblast: use fadeLayers to prevent visible borders

### 2024-03-18

scratchpad: Fixed -m command. Now it kills the preprocess of menu before
starting it.

### 2024-03-13

scratchpad: allow supplying command flags in any order

### 2024-03-02

hdrop: 0.4.4 -> 0.5.0\
Add --floating and associated options

### 2024-01-25

grimblast: fixed border still visible when taking screenshot of an area

### 2024-01-19

hdrop: -> 0.4.4\
Fix --class quoting

### 2024-01-14

hdrop: 0.3.0 -> 0.4.0\
Add `-c | --class`\
Improve Documentation\
Refactor

### 2024-01-11

Make Grimblast respect the `$SLURP_ARGS` environment variable, which controls
how `slurp` looks and behaves.

See `slurp -h` or `man slurp` for more information.

### 2022-02-26

Added the `edit` option to Grimblast. read the
[man page](grimblast/grimblast.1.scd) for more information.

A rofi script is also included.

### 2022-02-27

Added Scratchpad Script.
