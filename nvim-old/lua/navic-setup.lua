local navic = require("nvim-navic")
local navbuddy = require("nvim-navbuddy")
navic.setup({
  highlight = true,
})
navbuddy.setup({
  node_markers = {
    enabled = true,
    icons = {
      leaf = " ",
      leaf_selected = "→ ",
      branch = " ",
    },
  },
  window = { border = "none" },
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
      navbuddy.attach(client, bufnr)
      vim.keymap.set("n", "<leader>b", navbuddy.open, { desc = "Open [b]readcrumbs navigation" })
    end
  end,
})

function setup()
  if true then
    return true
  end
  require("incline").setup({
    hide = {
      cursorline = true,
      focused_win = false,
      only_win = false,
    },
    window = {
      padding = 0,
      margin = { horizontal = 0, vertical = 1 },
      placement = {
        horizontal = "left",
        vertical = "bottom",
      },
    },
    render = function(props)
      if not props.focused then
        return {}
      end
      if vim.api.nvim_get_mode()["mode"] == "i" then
        return {}
      end

      local navic_data = navic.get_data(props.buf)
      if not navic_data or #navic_data == 0 then
        return {}
      end

      local bg_color = string.format("#%x", vim.api.nvim_get_hl_by_name("NavicNormal", true).background)
      local res = {
        { "", guifg = bg_color },
      }
      for i, item in ipairs(navic_data) do
        table.insert(res, {
          {
            i == 1 and " " or "> ",
            group = "NavicSeparator",
          },
          { item.icon, group = "NavicIcons" .. item.type },
          { item.name, group = "NavicText" },
          " ",
          guibg = bg_color,
        })
      end
      table.insert(res, { "", guifg = bg_color })
      return res
    end,
  })
end

return {
  setup = setup,
}
