return {
  "rmagatti/alternate-toggler",
  config = function()
    local toggler = require("alternate-toggler")

    local ft_alts = {
      zig = {
        const = "var",
      },
      javascript = {
        const = "let",
      },
    }
    -- local group = vim.api.nvim_create_augroup("alternate_toggler_ft", { clear = true })
    -- for key, value in pairs(ft_alts) do
    --   vim.api.nvim_create_autocmd("FileType", {
    --     desc = "Setup custom alternates for file type " .. key,
    --     pattern = { key },
    --     group = group,
    --     callback = function(_)
    --       toggler.setup({ alternates = value })
    --     end,
    --   })
    -- end
    toggler.setup({
      const = "var",
    })

    vim.keymap.set("n", "<C-CR>t", toggler.toggleAlternate, { desc = "[t]oggle values" })
  end,
  event = { "BufReadPost" },
}
