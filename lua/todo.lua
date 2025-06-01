-- Todo List Floating Window Plugin
-- Add this to your init.lua or create a separate file in lua/todo.lua

local M = {}

-- Configuration
local config = {
	todo_file = vim.fn.expand("~/Documents/dev/todo.md"),
	window_width_percent = 80,
	window_height_percent = 80,
	border = "rounded", -- "single", "double", "rounded", "solid", "shadow"
}

-- Create floating window
local function create_floating_window()
	-- Get editor dimensions
	local width = vim.api.nvim_get_option("columns")
	local height = vim.api.nvim_get_option("lines")

	-- Calculate floating window size as percentage of screen
	local win_height = math.floor(height * (config.window_height_percent / 100))
	local win_width = math.floor(width * (config.window_width_percent / 100))

	-- Calculate position (centered)
	local row = math.floor((height - win_height) / 2)
	local col = math.floor((width - win_width) / 2)

	-- Window options
	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = config.border,
		title = " Todo List ",
		title_pos = "center",
	}

	-- Create buffer
	local buf = vim.api.nvim_create_buf(false, true)

	-- Create window
	local win = vim.api.nvim_open_win(buf, true, opts)

	-- Set buffer options
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

	-- Set window options
	vim.api.nvim_win_set_option(win, "wrap", true)
	vim.api.nvim_win_set_option(win, "cursorline", true)

	return buf, win
end

-- Read todo file
local function read_todo_file()
	local file = io.open(config.todo_file, "r")
	if not file then
		return { "# Todo List", "", "Todo file not found: " .. config.todo_file, "", "Create the file to get started!" }
	end

	local lines = {}
	for line in file:lines() do
		table.insert(lines, line)
	end
	file:close()

	if #lines == 0 then
		return { "# Todo List", "", "Your todo list is empty!", "", "Add some tasks to get started." }
	end

	return lines
end

-- Open todo floating window
function M.open_todo()
	local lines = read_todo_file()
	local buf, win = create_floating_window()

	-- Set buffer content
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Make buffer read-only
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "readonly", true)

	-- Set up keymaps for the floating window
	local function close_window()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	local function edit_todo()
		close_window()
		vim.cmd("edit " .. config.todo_file)
	end

	local function refresh_todo()
		local new_lines = read_todo_file()
		vim.api.nvim_buf_set_option(buf, "modifiable", true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
		vim.api.nvim_buf_set_option(buf, "modifiable", false)
	end

	-- Key mappings for the todo window
	local keymap_opts = { noremap = true, silent = true, buffer = buf }
	vim.keymap.set("n", "q", close_window, keymap_opts)
	vim.keymap.set("n", "<Esc>", close_window, keymap_opts)
	vim.keymap.set("n", "e", edit_todo, keymap_opts)
	vim.keymap.set("n", "r", refresh_todo, keymap_opts)

	-- Show help message
	vim.api.nvim_echo({
		{ "Todo List opened! ", "Normal" },
		{ "q/Esc", "WarningMsg" },
		{ ": close, ", "Normal" },
		{ "e", "WarningMsg" },
		{ ": edit, ", "Normal" },
		{ "r", "WarningMsg" },
		{ ": refresh", "Normal" },
	}, false, {})
end

-- Setup function to configure the plugin
function M.setup(opts)
	opts = opts or {}
	config = vim.tbl_deep_extend("force", config, opts)

	-- Ensure the directory exists
	local dir = vim.fn.fnamemodify(config.todo_file, ":h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end

	-- Create the todo file if it doesn't exist
	if vim.fn.filereadable(config.todo_file) == 0 then
		local default_content = {
			"# Todo List",
			"",
			"## Today",
			"- [ ] Example task 1",
			"- [ ] Example task 2",
			"",
			"## This Week",
			"- [ ] Example task 3",
			"- [ ] Example task 4",
			"",
			"## Later",
			"- [ ] Example task 5",
		}

		local file = io.open(config.todo_file, "w")
		if file then
			for _, line in ipairs(default_content) do
				file:write(line .. "\n")
			end
			file:close()
		end
	end
end

-- Create user command
vim.api.nvim_create_user_command("TodoList", M.open_todo, {
	desc = "Open todo list in floating window",
})

-- Optional: Create a keymap (uncomment to use)
-- vim.keymap.set("n", "<leader>td", M.open_todo, { desc = "Open Todo List" })

return M
