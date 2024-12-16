local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatOnWrite", {})
local function format_on_save_acmd(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

local function on_attach(client, bufnr)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Go to [D]eclaration" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "Go to [d]efinition" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0, desc = "Go to [i]mplementation" })
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = 0, desc = "Go to [r]eferences" })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = 0, desc = "Show [s]ignature help" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Show [K]ind of symbol" })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0, desc = "Re[n]ame symbol" })
  vim.keymap.set("n", "cd", vim.lsp.buf.rename, { desc = "Change [d]efinition (i.e. rename symbol)" })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code [a]ctions" })

  vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { buffer = 0, desc = "Go to [o]bject type definition" })
  -- vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = 0, desc = "Jump to signature help." })

  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = 0, desc = "Next [d]iagnostic" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = 0, desc = "Previous [d]iagnostic" })

  if vim.lsp.buf.range_code_action then
    vim.keymap.set("x", "<leader>ca", vim.lsp.buf.range_code_action, { buffer = 0, desc = "Range code [a]ctions" })
  else
    vim.keymap.set("x", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "Code [a]ctions" })
  end

  format_on_save_acmd(client, bufnr)
end

mason.setup()
mason_lspconfig.setup({
  handlers = {
    function(ls_name)
      lspconfig[ls_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ["ruff_lsp"] = function()
      lspconfig.ruff_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          settings = { args = { "--ignore=F405,F403" } },
        },
      })
    end,
    ["pyright"] = function()
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })
    end,
    ["jdtls"] = function()
      -- do nothing
    end,
    ["zls"] = function()
      lspconfig.zls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          zls = {
            enable_build_on_save = true,
            build_on_save_step = "check",
          },
        },
      })
    end,
  },
})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
  },
  on_attach = format_on_save_acmd,
})
