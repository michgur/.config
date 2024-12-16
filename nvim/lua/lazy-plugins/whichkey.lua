return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		icons = {
			mappings = false,
		},
		delay = function(ctx)
			return ctx.plugin and 0 or 50
		end,
		defer = function(ctx)
			return ctx.mode == "V" or ctx.mode == "<C-V>" or ctx.mode == "v"
		end,
	},
}
