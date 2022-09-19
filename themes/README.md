# Hyprland Community Themes

A collection of community-developed themes for use with Hyprland.

# Applying a theme

Themes in this repository are intended for drop-in use with Hyprland, and should be easy to apply while preserving your core configurations. To start using a theme, please follow the steps bellow:

1. Clone this repository to your local machine: 
```
git clone --recursive https://www.github.com/hyprwm/contrib
```

2. Navigate to the theme folder with 
```
cd ./contrib/themes
```

3. Create the theme directory in your hyprland config folder. All themes in this repository will expect to be placed in this directory: 
```
mkdir ~/.config/hypr/themes
```
 

4. Find the folders for any themes you want to use and copy them to the themes folder in your hyprland config folder. For example, to use the Garden theme run:
```
cp -r ./garden ~/.config/hypr/themes/
```

5. Assuming that we are applying the Garden theme, add the following line to the end of your hyprland.conf: 
```
source=~/.config/hypr/themes/garden/theme.conf
```

Be advised that these themes **DO NOT** provide a complete hyprland configuration. You will still need to handle all basic user-specific configuration in your `hyprland.conf` such as monitor setup, input device configuration, keybinds, execs, etc. This is done so that your basic user preferences can be kept separate and portable accross various themes.

# Contributing

Contributions are welcome! Please refer to these guidelines for formatting your theme in order to provide a consistent user experience. 

## Contribution Guidelines

The goal of this repository is to provide a collection of themes/rices that may be easily dropped in to any user's hyprland configuration with minimal setup, and without overriding the user's core configurations. In order to facilitate drop-in use of these themes, please format your theme according to the following guidelines.

1. Create a folder for your theme at `$HOME/.config/hypr/themes/<YOUR THEME>`. This is where you will place any and all files directly related to your theme, including:

	- Theme-related Hyprland configs.
	- Theme-relevant application configs (waybar, eww, dunst, kitty, etc.)
	- Wallpapers
	- Scripts

2. Create a file in your theme directory titled `theme.conf`. This is a Hyprland config file that will be sourced in the user's `hyprland.conf`. Please refer to the [Hyprland Wiki](https://wiki.hyprland.org/Configuring/Configuring-Hyprland) for configuration guidelines. 

	`theme.conf` should **ONLY** include configuration relevant to the theme, such as border colors, rounding, drop-shadows, blur, etc. User-specific setting such as monitors and input devices should **NEVER** be included here, and Binds and Execs should be included sparingly and only in reference to applications which are dependencies of the theme.

3. Create a markdown-formatted `README.md` in your theme folder providing any relevant details on usage of your theme and any provided scripts or application configurations, and most importantly providing a list of application dependencies.

4. Tweak your configurations as necessary to ensure that all file-paths point to your theme directory located at `$HOME/.config/hypr/themes/<YOUR THEME>`. For example:
	- Ensure that any execs in your `theme.conf` point to configurations included with your theme. For example, update `exec-once=waybar` to `exec-once=waybar -c ~/.config/hypr/theme/<YOUR THEME>/waybar/config`
	- Similarly, update any hard-coded file paths in your scripts and application configs to point the new locations of the files within your theme folder, for example updating file paths for eww defpolls in your `eww.yuck`, or updating wallpaper paths in `hyprpaper.conf`
5. Create a repository for your theme on GitHub.com and add the entire contents of your theme folder to the repository. Fork https://www.github.com/hyprwm/contrib, and add your theme repository as a submodule inside the `themes` folder. Open a Pull Request to submit your theme. (More detail forthcoming)
