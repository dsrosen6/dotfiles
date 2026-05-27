hl.monitor({
	output = "DP-1",
	mode = "3440x1440@174.96",
	position = "0x0",
	scale = "1.0",
})

hl.monitor({
	output = "eDP-1",
	mode = "1920x1200",
	position = "3440x480",
	scale = "1.25",
})

local function set_preferred_monitors()
	local preferred_monitor = "DP-1"
	for _, m in ipairs(hl.get_monitors()) do
		if m.name == "DP-1" then
			preferred_monitor = "DP-1"
			break
		end
	end

	for i = 1, 5 do
		hl.workspace_rule({
			workspace = tostring(i),
			monitor = preferred_monitor,
			persistent = true,
		})
	end
end

set_preferred_monitors()
hl.on("monitor.layout_changed", function()
	set_preferred_monitors()
end)
