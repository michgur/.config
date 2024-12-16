return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",      -- required
      "sindrets/diffview.nvim",     -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
    keys = {
      {
        "<leader>g",
        mode = { "n" },
        function()
          require("neogit").open({ kind = "replace" })
        end,
        desc = "[g]it",
      },
    },
  },
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
          map("n", "<C-g>s", gitsigns.stage_hunk, { desc = "[s]tage change" })
          map("n", "<C-g>d", gitsigns.reset_hunk, { desc = "[d]elete change" })
          map("v", "<C-g>s", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "[s]tage selected lines" })
          map("v", "<C-g>d", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "[d]elete changes in selected lines" })
          map("n", "<C-g>S", gitsigns.stage_buffer, { desc = "[S]tage buffer" })
          map("n", "<C-g>D", gitsigns.reset_buffer, { desc = "[D]elete changes in buffer" })
          map("n", "<C-g>u", gitsigns.undo_stage_hunk, { desc = "[u]ndo last stage" })
          map("n", "<C-g>g", gitsigns.preview_hunk_inline, { desc = "[g]it preview change" })
        end,
      })
    end,
  },
  -- {
  --   "f-person/git-blame.nvim",
  -- },
  -- {
  --   "tpope/vim-fugitive",
  -- },
  -- {
  --   "kdheepak/lazygit.nvim",
  --   cmd = {
  --     "LazyGit",
  --     "LazyGitConfig",
  --     "LazyGitCurrentFile",
  --     "LazyGitFilter",
  --     "LazyGitFilterCurrentFile",
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   keys = {
  --     { "<leader>gl", "<cmd>LazyGit<cr>", desc = "[l]azygit" },
  --   },
  -- },
}
