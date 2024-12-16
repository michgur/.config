return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	opts = {
		keymaps = {
			normal = "ys",
			normal_cur = "yss",
			delete = "ds",
			change = "cs",
			visual = "S",
			insert = false,
			insert_line = false,
			normal_line = false,
			normal_cur_line = false,
			visual_line = false,
			change_line = false,
		},
	},
	keys = {
		{
			"yS",
			function()
				vim.api.nvim_feedkeys("ys$", "m", false)
			end,
			desc = "Add a surrounding pair around line starting at cursor",
		},
	},
}
