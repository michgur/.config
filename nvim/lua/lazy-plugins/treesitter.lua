return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			auto_install = true,
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"python",
				"html",
				"css",
				"javascript",
				"typescript",
				"go",
				"jsdoc",
				"latex",
				"templ",
			},
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "v",
					node_decremental = "<M-v>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ae"] = "@parameter.outer",
						["ie"] = "@parameter.inner",
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		main = "treesitter-context",
		opts = {
			max_lines = 6,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}
