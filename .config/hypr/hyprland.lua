------------------
---- CONSTS ----
------------------

-- relevant directories
local config_dir = os.getenv("HOME") .. "/.config/hypr"
local script_dir = config_dir .. "/scripts"

-- monitor names
local monitor_1 = "DP-1"
local monitor_2 = "HDMI-A-1"

-- set monitor names as env
hl.env("MONITOR1", monitor_1)
hl.env("MONITOR2", monitor_2)

------------------
---- MONITORS ----
------------------

hl.monitor({
	output = monitor_1,
	mode = "2560x1440@144Hz",
	position = "0x0",
})
hl.monitor({
	output = monitor_2,
	mode = "1920x1080@60Hz",
	position = "2560x360",
})
---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "alacritty"
local fileManager = "nautilus"
local menu = "wofi"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	-- clipboard history
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	-- nightlight persistence
	hl.exec_cmd(config_dir .. "/waybar/scripts/bluelighttoggle.sh startup")
	-- gtk settings (probably unecessary)
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- cursors
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 10,
		gaps_out = 20,

		border_size = 2,

		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = false,

		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
		force_split = 2,
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us,de",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:win_space_toggle",
		kb_rules = "",
		numlock_by_default = true,

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd(script_dir .. "/screenshot.sh area"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(script_dir .. "/screenshot.sh active"))
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd(script_dir .. "/screenshot.sh screen"))

hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(script_dir .. "/open_clean_browser.sh"))

-- Fullscreen toggle
hl.bind("F11", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + comma", function()
	local mon1_workspace = hl.get_active_workspace(monitor_1)
	local mon2_workspace = hl.get_active_workspace(monitor_2)

	local mon1_windows = hl.get_windows({ workspace = mon1_workspace })
	local mon2_windows = hl.get_windows({ workspace = mon2_workspace })

	for _, window in ipairs(mon1_windows) do
		hl.dispatch(hl.dsp.window.move({ workspace = mon2_workspace, window = window }))
	end

	for _, window in ipairs(mon2_windows) do
		hl.dispatch(hl.dsp.window.move({ workspace = mon1_workspace, window = window }))
	end
end)

-- TODO: think about removing
-- hl.bind(mainMod .. " + SHIFT + period", hl.dsp.workspace.move({ monitor = "r" }))
-- hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.workspace.move({ monitor = "l" }))

-- Apps
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

hl.bind(mainMod .. " + Super_L", hl.dsp.exec_cmd("killall " .. menu .. " || " .. menu .. " --show drun"))
hl.bind(
	mainMod .. " + Super_R",
	hl.dsp.exec_cmd("killall " .. menu .. " || " .. terminal .. " -e " .. menu .. " --show run")
)

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("brave --incognito"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("discord"))

-- Window actions
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(script_dir .. "/cliphist-wofi-img.sh | wl-copy"))

-- Move focus vim-style
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move windows vim-style
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
--
-- Move focus with arrow keys
hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ direction = "down" }))

-- Move windows with arrow keys
hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.window.move({ direction = "down" }))

-- Switch / move to workspaces
for workspace = 1, 10 do
	local key = workspace % 10

	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
	hl.bind(mainMod .. " + CTRL + " .. key, function()
		local windows = hl.get_windows({ workspace = hl.get_active_workspace() })
		for _, window in ipairs(windows) do
			hl.dispatch(hl.dsp.window.move({ workspace = workspace, window = window }))
		end
	end)

	-- bind odd workspace to monitor1 and even to monitor2
	local workspace_monitor = workspace % 2 == 0 and monitor_2 or monitor_1
	hl.workspace_rule({ workspace = tostring(workspace), monitor = workspace_monitor })
end

-- Scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(script_dir .. "/volume_change.sh up"), {
	locked = true,
	repeating = true,
})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(script_dir .. "/volume_change.sh down"), {
	locked = true,
	repeating = true,
})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(script_dir .. "/volume_change.sh toggle"), {
	locked = true,
	repeating = true,
})
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), {
	locked = true,
	repeating = true,
})

-- Requires playerctl
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(script_dir .. "/media_keys.sh play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(script_dir .. "/media_keys.sh next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(script_dir .. "/media_keys.sh previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "steam-games-fullscreen",
	match = {
		class = "^(steam_app_.*)$",
		fullscreen = true,
	},
})

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})
