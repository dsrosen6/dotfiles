local swayosd = require("hyprland.modules.swayosd")
local knobDown = "XF86AudioLowerVolume"
local knobUp = "XF86AudioRaiseVolume"

local function uwsm(app) return "uwsm-app -- " .. app end

local function open_in_term(cmd) return "uwsm-app -- ghostty -e " .. cmd end

-- SYSTEM
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("loginctl lock-session"))

-- APPS / UTILITIES --
local terminal = uwsm("ghostty")
local files = open_in_term("yazi")
local menu = "python3 $XDG_CONFIG_HOME/fuzzel/menus.py"
local hyprSettings = menu .. " settings"

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + B", hl.dsp.exec_cmd(uwsm("firefox")))
hl.bind("SUPER + E", hl.dsp.exec_cmd(files))
hl.bind("CTRL + SHIFT + SPACE", hl.dsp.exec_cmd("1password --quick-access")) -- hyprctl reload to fix if not working
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + COMMA", hl.dsp.exec_cmd(hyprSettings))
hl.bind("SUPER + P", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind("CTRL + SHIFT + 3", hl.dsp.exec_cmd("grim - | swappy -f -")) -- full screenshot
hl.bind("CTRL + SHIFT + 4", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))

-- MENUS / OVERLAYS
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(menu .. " power"))
hl.bind("SUPER + C", hl.dsp.exec_cmd(menu .. " clipboard"))
hl.bind("SUPER + N", hl.dsp.exec_cmd(menu .. " noti"))
hl.bind("SUPER + SHIFT + Y", hl.dsp.exec_cmd("swaync-client -t"))

-- TILING / WORKSPACES --
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- DWINDLE LAYOUT --
hl.bind("SUPER + T", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind("SUPER + X", hl.dsp.layout("swapsplit"))

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- SCRATCHPAD --
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("S"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:S" }))
-- MOUSE BINDS --
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + SLASH", function()
	local ws = hl.get_active_workspace()
	if not ws then
		return
	end

	local new_layout = ws.tiled_layout == "dwindle" and "master" or "dwindle"
	hl.workspace_rule({
		workspace = tostring(ws.id),
		layout = new_layout,
	})
	hl.dispatch(swayosd.custom("Layout: " .. new_layout))
end)

-- MULTIMEDIA KEYS --
hl.bind("XF86MonBrightnessUp", swayosd.brightness_up, { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", swayosd.brightness_down, { locked = true, repeating = true })
hl.bind("XF86AudioNext", swayosd.next, { locked = true })
hl.bind("XF86AudioPause", swayosd.play_pause, { locked = true })
hl.bind("XF86AudioPlay", swayosd.play_pause, { locked = true })
hl.bind("XF86AudioPrev", swayosd.prev, { locked = true })
hl.bind("XF86AudioRaiseVolume", swayosd.vol_up, { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", swayosd.vol_down, { locked = true, repeating = true })
hl.bind("XF86AudioMute", swayosd.output_mute, { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", swayosd.input_mute, { locked = true, repeating = true })

-- SUBMAPS --
-- show a swayosd message when submap is changed
hl.on("keybinds.submap", function()
	local submap = hl.get_current_submap()
	submap = (submap == "" and "Default") or submap
	hl.dispatch(swayosd.custom("Submap: " .. submap, "preferences-desktop-keyboard"))
end)

hl.bind("SUPER + SEMICOLON", hl.dsp.submap("Resize"))
hl.define_submap("Resize", function()
	hl.bind("H", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })

	hl.bind(knobDown, hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
	hl.bind(knobUp, hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })

	hl.bind("SHIFT + H", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
	hl.bind("SHIFT + L", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })

	hl.bind(
		"MINUS",
		function() hl.config({ general = { gaps_in = hl.get_config("general.gaps_in").top - 1 } }) end,
		{ repeating = true }
	)

	hl.bind(
		"EQUAL",
		function() hl.config({ general = { gaps_in = hl.get_config("general.gaps_in").top + 1 } }) end,
		{ repeating = true }
	)

	hl.bind(
		"SHIFT + MINUS",
		function() hl.config({ general = { gaps_out = hl.get_config("general.gaps_out").top - 1 } }) end,
		{ repeating = true }
	)

	hl.bind(
		"SHIFT + EQUAL",
		function() hl.config({ general = { gaps_out = hl.get_config("general.gaps_out").top + 1 } }) end,
		{ repeating = true }
	)

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
	hl.bind("SEMICOLON", hl.dsp.submap("reset"))
end)

hl.bind("SUPER + M", hl.dsp.submap("Media"))
hl.define_submap("Media", function()
	hl.bind("H", swayosd.prev, { locked = true })
	hl.bind("J", swayosd.vol_down, { locked = true, repeating = true })
	hl.bind("K", swayosd.vol_up, { locked = true, repeating = true })
	hl.bind("L", swayosd.next, { locked = true })
	hl.bind("SPACE", swayosd.play_pause, { locked = true })

	hl.bind("SHIFT + J", swayosd.brightness_down, { locked = true, repeating = true })
	hl.bind("SHIFT + K", swayosd.brightness_up, { locked = true, repeating = true })

	hl.bind("S", hl.dsp.exec_cmd(uwsm("spotify")))
	hl.bind("ESCAPE", hl.dsp.submap("reset"))
	hl.bind("M", hl.dsp.submap("reset"))
end)
