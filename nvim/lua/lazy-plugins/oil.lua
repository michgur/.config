return {
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = true,
	},
	config = function()
		require("oil").setup({
			columns = { "icon" },
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
				is_hidden_file = function(name, bufnr)
					local m = name:match("^%.")
					return m ~= nil or name == "node_modules"
				end,
				is_always_hidden = function(name, bufnr)
					return false
				end,
			},
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = false,
			keymaps = {
				["<Esc>"] = "actions.close",
				["<CR>"] = "actions.select",
				["<tab>"] = "actions.select",
				["="] = "actions.select",
				["<S-tab>"] = "actions.parent",
				["<M-h>"] = "actions.select_split",
				["<M-v>"] = "actions.select_vsplit",
				["<C-l>"] = false,
				["<C-;>"] = "actions.refresh",
			},
		})
		vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open file tree" })
		vim.keymap.set("n", "_", "<cmd>Oil<CR>_", { desc = "Open file tree at cwd" })
	end,
}
