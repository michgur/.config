return {
  -- {
  --   "preservim/vimux",
  --   config = function()
  --     vim.g.VimuxRunnerType = "window"
  --
  --     vim.keymap.set("n", "<leader>x", function()
  --       vim.cmd("VimuxRunLastCommand")
  --       vim.cmd("VimuxZoomRunner")
  --     end, { desc = "E[x]ecute last shell command" })
  --
  --     vim.keymap.set("x", "<leader>x", function()
  --       local s = vim.fn.getpos("v")
  --       local e = vim.fn.getpos(".")
  --       if s[2] > e[2] then
  --         s, e = e, s
  --       elseif s[2] == e[2] then
  --         if s[3] > e[3] then
  --           s, e = e, s
  --         end
  --         e[3] = e[3] - s[3] + 1
  --       end
  --       -- get the text
  --       local lines = vim.api.nvim_buf_get_lines(0, s[2] - 1, e[2], false)
  --       if #lines == 0 then
  --         return
  --       end
  --
  --       lines[1] = string.sub(lines[1], s[3], #lines[1])
  --       lines[#lines] = string.sub(lines[#lines], 1, e[3])
  --       local cmd = table.concat(lines, "\\n")
  --       cmd = string.gsub(cmd, '"', '\\"')
  --       vim.cmd('VimuxRunCommand "' .. cmd .. '"')
  --       vim.cmd("VimuxZoomRunner")
  --     end, { desc = "e[x]ecute visual selection as shell command" })
  --   end,
  -- },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
