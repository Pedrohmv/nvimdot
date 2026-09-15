return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- Installed servers are auto-enabled via vim.lsp.enable() (automatic_enable defaults to true)
				ensure_installed = {
					"vtsls",
					"eslint",
					"jsonls",
					"yamlls",
					"tailwindcss",
					"lua_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("ols", {
				init_options = {
					checker_args = "-strict-style",
					collections = {
						{ name = "shared", path = vim.fn.expand("$HOME/odin-lib") },
					},
				},
			})
			vim.lsp.enable("ols")
		end,
	},
}
