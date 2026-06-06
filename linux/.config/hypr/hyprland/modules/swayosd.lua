local function swayosd_exec(cmd)
	return hl.dsp.exec_cmd("swayosd-client " .. cmd)
end

---@param message string
---@param icon string?
local function swayosd_custom(message, icon)
	local cmd = string.format('--custom-message "%s"', message)
	if icon then
		cmd = cmd .. string.format(' --custom-icon "%s"', icon)
	end
	return swayosd_exec(cmd)
end

local M = {
	brightness_up = swayosd_exec("--brightness +5"),
	brightness_down = swayosd_exec("--brightness -5"),
	next = swayosd_exec("--playerctl next"),
	prev = swayosd_exec("--playerctl prev"),
	play_pause = swayosd_exec("--playerctl play-pause"),
	vol_up = swayosd_exec("--output-volume raise"),
	vol_down = swayosd_exec("--output-volume lower"),
	output_mute = swayosd_exec("--output-volume mute-toggle"),
	input_mute = swayosd_exec("--input-volume mute-toggle"),
	custom = swayosd_custom,
}

return M
