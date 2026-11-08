# Hyprland

Personal Hyprland desktop configuration using the Lua API. with a dwindle

## Files

| File                  | Purpose                                                                                                      |
| --------------------- | ------------------------------------------------------------------------------------------------------------ |
| `hyprland.lua`        | Monitors, appearance, input, startup commands, keybindings, and window rules.                                |
| `uni_windowrules.lua` | Window rules for university subject specific apps                                                            |
| `hypridle.conf`       | Turns displays off after 5 minutes and suspends after 10 minutes of inactivity; restores displays on resume. |
| `hyprlock.conf`       | Lock-screen appearance, including time, date, avatar, and password input.                                    |
| `hyprpaper.conf`      | Wallpaper settings for both monitors.                                                                        |
| `swaync.conf`         | Hyprland layer rules for SwayNC blur, not SwayNC's own configuration.                                        |
| `scripts/`            | Clipboard, screenshot, browser, volume, and media helpers.                                                   |
| `icons/`              | Volume notification icons.                                                                                   |
| `.luarc.json`         | Lua language-server settings.                                                                                |

## Dependencies

Install the tools for the features you use:

### Desktop

- `hyprland`
- `hypridle`
- `hyprlock`
- `hyprpaper`
- `swaync`

### Applications and session:

- `alacritty`
- `nautilus`
- `brave-origin`
- `wofi`
- `discord`
- `xdg-utils`
- `uwsm`

### Clipboard

- `wl-clipboard`,
- `cliphist`
- `magick`
- `rg`

### Screenshots

- `grim`
- `slurp`
- `hyprpicker`
- `jq`
- `satty`
- `notify-send` (provided by libnotify)

### Audio and media:

- `wpctl` (WirePlumber)
- `playerctl`
- `curl`
- `notify-send`

### Appearance

- `gsettings`
- `adw-gtk3-dark`
- `qt6ct`
- Bibata-Modern-Classic cursors
- JetBrainsMono Nerd Font.

## Startup and input

The `hyprland.start` handler starts clipboard watchers for text and images,
invokes the night-light persistence helper, and applies dark GTK settings.
It does not launch Hypridle, Hyprlock, Hyprpaper, or a notification daemon.
The idle configuration turns off displays and suspends, but does not invoke a
screen locker.

Keyboard layouts are US (`altgr-intl`) and German, toggled with `Super + Space`.
Num Lock is enabled by default. Three-finger horizontal swipes change workspaces,
and touchpad scrolling uses natural direction.

## Monitors and workspaces

| Monitor    | Mode                | Position   | Workspaces           |
| ---------- | ------------------- | ---------- | -------------------- |
| `DP-1`     | 2560×1440 at 144 Hz | `0x0`      | Odd: 1, 3, 5, 7, 9   |
| `HDMI-A-1` | 1920×1080 at 60 Hz  | `2560x360` | Even: 2, 4, 6, 8, 10 |

`Super + ,` exchanges the active workspaces' contents between the two monitors,
preserving tiling trees and split ratios while keeping each monitor's original
workspace number. The named special workspace `magic` acts as a scratchpad.

## Keybindings

`Super` is the main modifier. For workspace shortcuts, `0` means workspace 10.

| Shortcut                                | Action                                                                                                         |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Left Super (release)                    | Toggle Wofi application launcher.                                                                              |
| Right Super (release)                   | Toggle Wofi command runner inside Alacritty.                                                                   |
| `Super + Q`                             | Open Alacritty.                                                                                                |
| `Super + E`                             | Open a new Nautilus window.                                                                                    |
| `Super + B` / `Super + Shift + B`       | Open Brave / an incognito window.                                                                              |
| `Super + D`                             | Open Discord.                                                                                                  |
| `Super + Ctrl + Shift + Alt + L`        | Open LinkedIn in the default browser.                                                                          |
| `Super + F1`                            | Switch to workspaces 9 and 10, hide the scratchpad if visible, and launch the default browser on workspace 9.  |
| `Super + C`                             | Close the focused window.                                                                                      |
| `Super + Shift + M`                     | Stop the UWSM session.                                                                                         |
| `F11`                                   | Toggle fullscreen.                                                                                             |
| `Super + F`                             | Toggle floating.                                                                                               |
| `Super + P`                             | Toggle pseudotiling.                                                                                           |
| `Super + O`                             | Toggle the dwindle split direction.                                                                            |
| `Super + V`                             | Choose clipboard history, copy the selection, and send `Ctrl + V`.                                             |
| `Super + H/J/K/L` or arrow keys         | Focus left/down/up/right.                                                                                      |
| `Super + Shift + H/J/K/L` or arrow keys | Move the focused window in that direction.                                                                     |
| `Super + 1–0`                           | Focus a workspace.                                                                                             |
| `Super + Shift + 1–0`                   | Move the focused window to a workspace.                                                                        |
| `Super + Ctrl + 1–0`                    | Move all windows from the active workspace to a workspace.                                                     |
| `Super + ,`                             | Exchange contents between the two active monitor workspaces.                                                   |
| `Super + S`                             | Toggle the scratchpad.                                                                                         |
| `Super + Shift + S`                     | Move the focused window to the scratchpad.                                                                     |
| `Super + mouse wheel`                   | Cycle existing workspaces.                                                                                     |
| `Super + left/right mouse drag`         | Move/resize a window.                                                                                          |
| `Print`                                 | Screenshot a selected area or window.                                                                          |
| `Ctrl + Print`                          | Screenshot the active window.                                                                                  |
| `Ctrl + Shift + Print`                  | Screenshot all visible outputs.                                                                                |
| Volume up/down/mute keys                | Change output volume by 2 percentage points (capped at 100% when raising) or toggle mute, with a notification. |
| Microphone mute key                     | Toggle the default microphone's mute state.                                                                    |
| Play/pause, next, previous keys         | Control media playback, with a track notification.                                                             |

## Helper scripts

| Script                  | Usage and behavior                                                                                                                                                    |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `screenshot.sh`         | `area`, `active`, or `screen`; saves a timestamped PNG under `~/Pictures/screenshots` and copies it to the clipboard. The notification can open Satty for annotation. |
| `grimblast.sh`          | Bundled, modified Grimblast implementation used by `screenshot.sh`; supports `usage` and `check` commands.                                                            |
| `cliphist-wofi-img.sh`  | Opens clipboard history in Wofi with image thumbnails and writes the selected entry to stdout; the keybinding handles copying and pasting.                            |
| `open_clean_browser.sh` | Selects workspaces 9 and 10 and launches the default browser on workspace 9.                                                                                          |
| `volume_change.sh`      | `up`, `down`, or `toggle`; adjusts the default audio sink and displays a volume notification.                                                                         |
| `media_keys.sh`         | `play-pause`, `next`, or `previous`; prefers a playing MPRIS player, otherwise the remembered player or first available player, and displays track information.       |

Window rules suppress maximize requests, work around focus issues for certain
XWayland windows, fullscreen Steam games, and float Steam Friends, Ipe's waiting
window, and selected 3D Viewer controls.
