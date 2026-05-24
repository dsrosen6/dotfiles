local mainMod = "SUPER"
local function bind_exec(mod, key, cmd)
	hl.bind(mod .. " + " .. key, hl.dsp.exec_cmd(cmd))
end

local function super_exec(key, cmd)
	bind_exec(mainMod, key, cmd)
end

---@param dsp HL.Dispatcher
---@param opts HL.BindOptions?
local function super_bind(key, dsp, opts)
	hl.bind(mainMod .. " + " .. key, dsp, opts)
end

local terminal = "uwsm-app -- ghostty"
local files = "uwsm-app -- ghostty -e yazi"
local browser = "uwsm-app -- firefox"

local menu = "$HOME/.config/rofi/rofi.sh"
local screenshot = 'grim -g "$(slurp)" - | swappy -f -'

-- APPS / UTILITIES --
super_exec("RETURN", terminal)
super_exec("B", browser)
super_exec("E", files)
super_exec("SPACE", menu)
super_exec("P", "$HOME/.config/waybar/toggle.sh")
bind_exec("CTRL", "SHIFT + 4", screenshot)

-- MENUS
bind_exec("CTRL", "SPACE", menu)
super_exec("SHIFT + P", menu .. " power")
super_exec("C", menu .. " clipboard")

-- TILING / WORKSPACES --
super_bind("Q", hl.dsp.window.close())
super_bind("V", hl.dsp.window.float({ action = "toggle" }))
super_bind("H", hl.dsp.focus({ direction = "left" }))
super_bind("J", hl.dsp.focus({ direction = "down" }))
super_bind("K", hl.dsp.focus({ direction = "up" }))
super_bind("L", hl.dsp.focus({ direction = "right" }))
super_bind("SHIFT + H", hl.dsp.window.move({ direction = "left" }))
super_bind("SHIFT + J", hl.dsp.window.move({ direction = "down" }))
super_bind("SHIFT + K", hl.dsp.window.move({ direction = "up" }))
super_bind("SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- DWINDLE LAYOUT --
super_bind("T", hl.dsp.layout("togglesplit")) -- dwindle only
super_bind("X", hl.dsp.layout("swapsplit"))

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- SCRATCHPAD --
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- MOUSE BINDS --
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- MULTIMEDIA KEYS --
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
