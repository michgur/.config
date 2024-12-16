local cmp = require("cmp")
local lsnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
local lspkind = require("lspkind")

lsnip.setup({
  history = true,
  update_events = { "TextChanged", "TextChangedI" },
  enable_autosnippets = true,
})
cmp.setup({
  snippet = {
    expand = function(args)
      lsnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
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
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip", option = { show_autosnippets = true } },
  }, {
    { name = "path" },
    { name = "buffer" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
      show_labelDetails = true,
      symbol_map = { Copilot = "" },
    }),
  },
  window = {
    completion = {
      winhighlight = "NormalFloat:CmpNormal",
    },
  },
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
  loadfile(ft_path)()
end

vim.keymap.set("i", "<M-j>", function()
  if lsnip.expand_or_jumpable() then
    lsnip.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set("i", "<M-k>", function()
  if lsnip.jumpable(-1) then
    lsnip.jump(-1)
  end
end, { silent = true })
