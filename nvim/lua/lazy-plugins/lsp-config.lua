return {
	"neovim/nvim-lspconfig",
	-- dependencies = { "saghen/blink.cmp" },
	config = require("config.lsp").setup,
}
