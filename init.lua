-- local util = require "custom.configs.util"

local autocmd = vim.api.nvim_create_autocmd
-- local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- buffer
-- vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
--   callback = function()
--     vim.t.bufs = vim.tbl_filter(function(bufnr)
--       return vim.api.nvim_buf_get_option(bufnr, "modified")
--     end, vim.t.bufs)
--   end,
-- })

-- goToTab
for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

autocmd("FileType", {
  pattern = { "typescriptreact", "typescript" },
  callback = function()
    vim.opt.expandtab = false
  end,
})

-- fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- show trailing whitespaces
-- util.toggle_trailing_space()

vim.o.termguicolors = true
vim.opt.wrap = false

-- don't create backup files
vim.opt.swapfile = false
