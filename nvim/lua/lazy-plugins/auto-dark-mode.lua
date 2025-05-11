local function setup_palette(palette)
	local theme_colors = require("catppuccin.palettes").get_palette(palette)
	require("tiny-devicons-auto-colors").setup({ colors = theme_colors })

	vim.cmd.colorscheme("catppuccin-" .. palette)
end

return {
	"f-person/auto-dark-mode.nvim",
	lazy = false,
	priority = 1000,
	dependencies = { "nvim-tree/nvim-web-devicons", "rachartier/tiny-devicons-auto-colors.nvim" },
	opts = {
		update_interval = 1000,
		set_dark_mode = function()
			vim.api.nvim_set_option_value("background", "dark", {})
			setup_palette("macchiato")
		end,
		set_light_mode = function()
			vim.api.nvim_set_option_value("background", "light", {})
			setup_palette("latte")
		end,
	},
}
