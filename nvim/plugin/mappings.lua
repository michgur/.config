-- system copy / paste
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', { desc = "[y]ank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<Leader>Y", '"+y$', { desc = "[Y]ank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<Leader>p", '"+p', { desc = "[p]aste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<Leader>P", '"+P', { desc = "[P]aste from system clipboard" })

-- normal mode navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- fix go to file start
vim.keymap.set({ "n", "x" }, "gg", "gg0", {})

local function multiline_dup_up()
	local s = vim.fn.getpos("v")
	local e = vim.fn.getpos(".")

	local sp = math.min(s[2], e[2])
	local ep = math.max(s[2], e[2])

	vim.cmd(sp .. "," .. ep .. "t " .. (sp - 1))

	vim.cmd("normal! :noh")
	vim.api.nvim_win_set_cursor(0, { s[2], s[3] })
	vim.cmd("normal V")
	vim.api.nvim_win_set_cursor(0, { e[2], e[3] })
end

local function multiline_dup_down()
	local s = vim.fn.getpos("v")
	local e = vim.fn.getpos(".")

	local sp = math.min(s[2], e[2])
	local ep = math.max(s[2], e[2])

	vim.cmd(sp .. "," .. ep .. "t " .. ep)

	vim.cmd("normal! :noh")
	vim.api.nvim_win_set_cursor(0, { ep + 1, 0 })
	vim.cmd("normal V")
	vim.api.nvim_win_set_cursor(0, { 2 * ep - sp + 1, 0 })
end

-- move / duplicate lines
vim.keymap.set("n", "<M-J>", "<cmd>t .<CR>", {})
vim.keymap.set("v", "<M-J>", multiline_dup_down, {})
vim.keymap.set("n", "<M-K>", "<cmd>t .-1<CR>", {})
vim.keymap.set("v", "<M-K>", multiline_dup_up, {})

-- add empty lines
vim.keymap.set("n", "<M-O>", "O<Esc>j", {})
vim.keymap.set("n", "<M-o>", "o<Esc>k", {})

-- navigation
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-o>", "<C-o>zz", {})
vim.keymap.set("n", "<C-i>", "<C-i>zz", {})

vim.keymap.set("n", "<C-z>", "<cmd>bd<CR>")
vim.keymap.set("n", "<C-Z>", "<cmd>bd!<CR>")

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
