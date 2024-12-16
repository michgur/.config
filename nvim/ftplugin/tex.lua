local p = vim.fs.basename(vim.fn.expand("%")):sub(1, -5)

vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = 0,
  callback = function()
    vim.cmd("call jobstart(\"pdflatex '" .. p .. "'.tex && rm " .. p .. ".aux " .. p .. '.log")')
  end,
})

vim.keymap.set(
  "n",
  "<LEADER>o",
  ":!open -a Preview '" .. p .. ".pdf'<CR>",
  { desc = "[o]pen in preview", buffer = true }
)
