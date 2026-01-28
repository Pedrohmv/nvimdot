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
			require("mason-lspconfig").setup()
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
