local status_ok, nvim_tree = pcall(require, "autosave")
if not status_ok then
	return
end

local autosave = require("autosave")

autosave.setup({
	enabled = true,
	execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
	events = { "CursorHold" },
	conditions = {
		exists = true,
		filename_is_not = {},
		filetype_is_not = {},
		modifiable = true,
	},
	write_all_buffers = true,
	on_off_commands = true,
	clean_command_line_interval = 0,
	debounce_delay = 4000,
})