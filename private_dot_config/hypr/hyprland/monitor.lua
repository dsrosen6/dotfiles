local external = {
	output = "DP-1",
	mode = "3440x1440@174.96",
	position = "0x0",
	scale = "1.0",
}

local laptop = {
	output = "eDP-1",
	mode = "1920x1200",
	position = "3440x480",
	scale = "1.25",
}

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

local function external_found()
	local monitor = hl.get_monitor(external.output)
	return monitor ~= nil
end

local function lid_should_disable()
	if not lid_open() and external_found() then
		return true
	end
	return false
end

local function handle_lid()
	hl.monitor({
		output = laptop.output,
		mode = laptop.mode,
		position = laptop.position,
		scale = laptop.scale,
		disabled = lid_should_disable(),
	})
end

local function set_preferred_monitors()
	local preferred_monitor = laptop.output
	for _, m in ipairs(hl.get_monitors()) do
		if m.name == external.output then
			preferred_monitor = external.output
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

-- startup monitor initializations; if laptop monitor isn't declared in some way,
-- it will enable by default regardless of functions run
hl.monitor({
	output = external.output,
	mode = external.mode,
	position = external.position,
	scale = external.scale,
})

hl.monitor({
	output = laptop.output,
	mode = laptop.mode,
	position = laptop.position,
	scale = laptop.scale,
	disabled = lid_should_disable(),
})

-- then, find out if laptop montior should be disabled based on lid state
handle_lid()
hl.bind("switch:Lid Switch", handle_lid)

-- handle monitor persistent workspaces go to based on lid state
set_preferred_monitors()
hl.on("monitor.layout_changed", set_preferred_monitors)
