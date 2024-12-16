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
