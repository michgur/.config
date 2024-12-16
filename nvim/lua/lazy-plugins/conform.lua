return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = { lua = { "stylua" } },
		format_after_save = { lsp_format = "fallback" },
	},
}
