# hyprosd-mako

Lightweight OSD (On-Screen Display) notifications for Hyprland using Mako.

Provides:
- Volume change OSD (`volume-notify`)
- Brightness change OSD (`brightness-notify`)
- Microphone mute/unmute OSD (`mic-notify`)

## Dependencies
- mako + makoctl
- notify-send
- PipeWire (`wpctl`)
- brightnessctl

## Installation
```
make
sudo make install
```

## Uninstall
```
sudo make uninstall
```

## Usage (Hyprland binds)
Add these to your Hyprland config:

```
# Volume
bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && volume-notify
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && volume-notify
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && volume-notify
# Brightness
bindel = ,XF86MonBrightnessUp, exec, brightnessctl set +5% && brightness-notify
bindel = ,XF86MonBrightnessDown, exec, brightnessctl set 5%- && brightness-notify
# Microphone
bindel = $mainMod, M, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && mic-notify
```

## Why this helps
Hyprland has no built-in OSD with Mako.
This provides a minimal, fast, Wayland-native alternative with almost no dependencies.

## Notes
Tested on Arch Linux with Hyprland and Mako.  
Should work on any distribution with the required dependencies.
