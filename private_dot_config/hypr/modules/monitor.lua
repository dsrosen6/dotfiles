local external_monitor = {
	output = "DP-1",
	mode = "3440x1440@174.96",
	position = "0x0",
	scale = "1.0",
}

local laptop_monitor = {
	output = "eDP-1",
	mode = "1920x1200",
	position = "3440x480",
	scale = "1.25",
}

---@param monitors HL.Monitor[]
local function monitor_found(name, monitors)
	for _, m in ipairs(monitors) do
		if m.name == name then
			return true
		end
	end
	return false
end

local function lid_open()
	local handle = io.popen("cat /proc/acpi/button/lid/LID/state")
	local lid_state = ""
	if handle then
		lid_state = handle:read("*a")
		handle:close()
	end
	if lid_state:find("closed") then
		return false
	else
		return true
	end
end

local function lid_should_disable()
	local monitors = hl.get_monitors()
	if not lid_open() and monitor_found("DP-1", monitors) then
		return true
	end
	return false
end

local function handle_lid()
	local lm = laptop_monitor
	hl.monitor({
		output = laptop_monitor.output,
		mode = laptop_monitor.mode,
		position = laptop_monitor.position,
		scale = laptop_monitor.scale,
		disabled = lid_should_disable(),
	})
end

local function preferred_monitor(primary, fallback)
	for _, m in ipairs(hl.get_monitors()) do
		if m.name == primary then
			return primary
		end
	end
	return fallback
end

local function set_preferred_monitors()
	for i = 1, 5 do
		hl.workspace_rule({
			workspace = tostring(i),
			monitor = preferred_monitor("DP-1", "eDP-1"),
			persistent = true,
		})
	end
end

hl.monitor({
	output = external_monitor.output,
	mode = external_monitor.mode,
	position = external_monitor.position,
	scale = external_monitor.scale,
})

hl.monitor({
	output = laptop_monitor.output,
	mode = laptop_monitor.mode,
	position = laptop_monitor.position,
	scale = laptop_monitor.scale,
	disabled = lid_should_disable(),
})

handle_lid()
hl.bind("switch:Lid Switch", handle_lid)

hl.workspace_rule({
	workspace = "1",
	monitor = preferred_monitor("DP-1", "eDP-1"),
})

set_preferred_monitors()
hl.on("monitor.layout_changed", set_preferred_monitors)
