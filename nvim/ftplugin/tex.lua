local cwd = vim.fn.expand("%:h")
local fname = vim.fn.expand("%:t:r")
local out_path = "'" .. cwd .. "/" .. fname .. ".pdf'"

local function on_pdflatex_exit(out)
	if out.code == 0 then
		vim.system({ "rm", fname .. ".aux", fname .. ".log" }, { cwd = cwd })
		vim.api.nvim_echo({ { "Exported file to " .. out_path } }, true, {})
	else
		vim.system({ "rm", fname .. ".aux" }, { cwd = cwd })
		vim.api.nvim_echo({ { "Failed to export to .pdf, view " .. fname .. ".log for details" } }, true, {})
	end
end

vim.api.nvim_create_autocmd("BufWritePre", {
	buffer = 0,
	callback = function()
		vim.system({ "pdflatex", fname .. ".tex" }, { cwd = cwd }, vim.schedule_wrap(on_pdflatex_exit))
	end,
})

vim.keymap.set(
	"n",
	"<LEADER>o",
	":!open -a Preview " .. out_path .. "<CR>",
	{ desc = "[o]pen in preview", buffer = true }
)
