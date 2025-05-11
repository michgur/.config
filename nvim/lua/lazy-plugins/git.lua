return {
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim", -- required
	-- 		"sindrets/diffview.nvim", -- optional - Diff integration
	-- 	},
	-- 	config = true,
	-- 	keys = {
	-- 		{
	-- 			"<leader>gg",
	-- 			mode = { "n" },
	-- 			function()
	-- 				require("neogit").open({ kind = "replace" })
	-- 			end,
	-- 			desc = "[g]it",
	-- 		},
	-- 	},
	-- },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				signs_staged_enable = false,
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Next / prev change
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, { desc = "Next [c]hange" })
					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Previous [c]hange" })

					-- Actions
					map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[s]tage change" })
					map("n", "<leader>gd", gitsigns.reset_hunk, { desc = "[d]elete change" })
					map("v", "<leader>gs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "[s]tage selected lines" })
					map("v", "<leader>gd", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "[d]elete changes in selected lines" })
					map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[S]tage buffer" })
					map("n", "<leader>gD", gitsigns.reset_buffer, { desc = "[D]elete changes in buffer" })
					map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "[u]ndo last stage" })
					map("n", "<leader>gp", gitsigns.preview_hunk_inline, { desc = "[g]it preview change" })
				end,
			})
		end,
	},
}
