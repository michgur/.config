local function setup_keymaps()
	local fzf = require("fzf-lua")

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
		buffer = 0,
		desc = "Go to [D]eclaration",
	})
	-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
	-- 	buffer = 0,
	-- 	desc = "Go to [D]eclaration",
	-- })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
		buffer = 0,
		desc = "Go to [d]efinition",
	})
	vim.keymap.set("n", "gR", vim.lsp.buf.implementation, { buffer = 0, desc = "Go to implementation" })
	vim.keymap.set("n", "gr", fzf.lsp_references, { buffer = 0, desc = "Go to [r]eferences" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Show [K]ind of symbol" })
	vim.keymap.set("n", "cd", vim.lsp.buf.rename, { buffer = 0, desc = "Change [d]efinition (i.e. rename symbol)" })
	vim.keymap.set({ "n", "v" }, "<leader>a", fzf.lsp_code_actions, { buffer = 0, desc = "Code [a]ctions" })

	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = 0, desc = "Next [d]iagnostic" })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = 0, desc = "Previous [d]iagnostic" })
end

return {
	setup = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- local capabilities = require("blink.cmp").get_lsp_capabilities()

		lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, {
			on_attach = setup_keymaps,
			capabilities = capabilities,
		})

		lspconfig.lua_ls.setup({})
		lspconfig.html.setup({})
		lspconfig.cssls.setup({})
		lspconfig.tailwindcss.setup({})
		lspconfig.ts_ls.setup({
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/opt/homebrew/lib/node_modules/@vue/language-server/",
						languages = { "vue" },
					},
				},
			},
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"vue",
			},
		})
		lspconfig.volar.setup({
			init_options = {
				typescript = {
					tsdk = "/opt/homebrew/lib/node_modules/typescript/lib",
				},
			},
		})
		lspconfig.ruff.setup({
			on_attach = function(client)
				client.server_capabilities.hoverProvider = false
				client.server_capabilities.diagnosticProvider = false
			end,
		})
		lspconfig.pyright.setup({
			settings = {
				pyright = {
					disableOrganizeImports = true,
				},
				python = {
					analysis = {
						typeCheckingMode = "standard",
					},
				},
			},
		})
		lspconfig.zls.setup({
			settings = {
				zls = {
					enable_build_on_save = true,
					build_on_save_step = "check",
				},
			},
		})
	end,
}
