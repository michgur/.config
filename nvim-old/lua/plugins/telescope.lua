return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<D-F>", builtin.find_files, {})
      vim.keymap.set("n", "<D-f>", builtin.live_grep, {})

      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search [h]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search [k]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search [f]iles" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current [w]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by [g]rep" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader>st", builtin.treesitter, { desc = "Search current file ([t]reesitter)" })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "Search [n]eovim files" })

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          color_devicons = true,
          layout_config = {
            prompt_position = "top",
            center = {
              mirror = true,
              preview_cutoff = 0,
              width = { 0.9, max = 100 },
            },
            cursor = {
              width = 30,
              height = 10,
            },
          },
          sorting_strategy = "ascending",
          layout_strategy = "center",
        },
        pickers = {},
        extensions = {
          -- TODO: use dressing instead
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              layout_strategy = "cursor",
            }),
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
}
