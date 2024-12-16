return {
	"ibhagwan/fzf-lua",
	config = function()
		local fzf = require("fzf-lua")
		-- calling `setup` is optional for customization
		fzf.setup({
			fzf_colors = {
				["fg"] = { "fg", "CursorLine" },
				["bg"] = { "bg", "Normal" },
				["hl"] = { "fg", "Comment" },
				["fg+"] = { "fg", "Normal" },
				["bg+"] = { "bg", "CursorLine" },
				["hl+"] = { "fg", "Statement" },
				["info"] = { "fg", "PreProc" },
				["prompt"] = { "fg", "Conditional" },
				["pointer"] = { "fg", "Exception" },
				["marker"] = { "fg", "Keyword" },
				["spinner"] = { "fg", "Label" },
				["header"] = { "fg", "Comment" },
				["gutter"] = "-1",
			},
		})

		vim.keymap.set("n", "<Leader>f", fzf.files, { desc = "Search [f]iles" })
		vim.keymap.set("n", "<Leader>h", fzf.helptags, { desc = "Search [h]elp" })
		vim.keymap.set("n", "<Leader>/", fzf.live_grep_native, { desc = "Search with grep [/]" })
		vim.keymap.set("n", "<Leader>d", fzf.diagnostics_document, { desc = "Search file [d]iagnostics" })
		vim.keymap.set("n", "<Leader>.", fzf.oldfiles, { desc = "Search old files [.]" })
		vim.keymap.set("n", "<Leader> ", fzf.buffers, { desc = "Search buffers [ ]" })
	end,
}
