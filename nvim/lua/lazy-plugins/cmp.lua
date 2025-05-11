-- return {
-- 	"saghen/blink.cmp",
-- 	dependencies = { "rafamadriz/friendly-snippets" },
-- 	version = "1.*",
-- 	opts = {
-- 		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
-- 		-- 'super-tab' for mappings similar to vscode (tab to accept)
-- 		-- 'enter' for enter to accept
-- 		-- 'none' for no mappings
-- 		--
-- 		-- All presets have the following mappings:
-- 		-- C-space: Open menu or open docs if already open
-- 		-- C-n/C-p or Up/Down: Select next/previous item
-- 		-- C-e: Hide menu
-- 		-- C-k: Toggle signature help (if signature.enabled = true)
-- 		--
-- 		-- See :h blink-cmp-config-keymap for defining your own keymap
-- 		keymap = { preset = "super-tab" },
-- 		appearance = { nerd_font_variant = "mono" },
-- 		completion = {
-- 			documentation = { auto_show = false },
-- 			trigger = {},
-- 		},
-- 		sources = {
-- 			default = { "lsp", "path", "snippets", "buffer" },
-- 			providers = {
-- 				lsp = {
-- 					override = {
-- 						get_trigger_characters = function(self)
-- 							local t = self:get_trigger_characters()
-- 							vim.list_extend(t, { ".", "#", "@" })
-- 							vim.print(vim.inspect(t))
-- 							return t
-- 						end,
-- 					},
-- 				},
-- 			},
-- 		},
-- 		fuzzy = {
-- 			implementation = "prefer_rust_with_warning",
-- 			sorts = {
-- 				function(a, b)
-- 					local ap = a.source_id == "buffer"
-- 					local bp = b.source_id == "buffer"
-- 					if ap ~= bp then
-- 						return bp
-- 					end
-- 				end,
-- 				"score",
-- 				"sort_text",
-- 			},
-- 		},
-- 	},
-- 	opts_extend = { "sources.default" },
-- }

return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		opts = {
			history = true,
			update_events = { "TextChanged", "TextChangedI" },
			enable_autosnippets = true,
		},
		keys = function()
			local lsnip = require("luasnip")
			return {
				{
					"<M-j>",
					function()
						if lsnip.expand_or_jumpable() then
							lsnip.expand_or_jump()
						end
					end,
					mode = "i",
					desc = "Expand snippet or jump forward",
					silent = true,
				},
				{
					"<M-k>",
					function()
						if lsnip.jumpable(-1) then
							lsnip.jump(-1)
						end
					end,
					mode = "i",
					desc = "Expand snippet or jump forward",
					silent = true,
				},
			}
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
		opts = function()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
			require("luasnip.loaders.from_vscode").lazy_load()

			local cmp = require("cmp")
			local lsnip = require("luasnip")

			return {
				snippet = {
					expand = function(args)
						lsnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<M-.>"] = cmp.mapping({
						i = function()
							if cmp.visible() then
								cmp.abort()
							else
								cmp.complete()
							end
						end,
						c = function()
							if cmp.visible() then
								cmp.close()
							else
								cmp.complete()
							end
						end,
					}),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<tab>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip", option = { show_autosnippets = true } },
				}, {
					{ name = "path" },
					{ name = "buffer" },
				}),
			}
		end,
	},
}
