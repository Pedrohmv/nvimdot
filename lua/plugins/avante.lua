return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- set this if you want to always pull the latest change
	opts = {
		behaviour = {
			use_cwd_as_project_root = true,
		},
	},
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"echasnovski/mini.icons",
		"ibhagwan/fzf-lua",
	},
}
