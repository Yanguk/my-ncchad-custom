local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- buffer
vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
  callback = function()
    vim.t.bufs = vim.tbl_filter(function(bufnr)
      return vim.api.nvim_buf_get_option(bufnr, "modified")
    end, vim.t.bufs)
  end,
})

-- fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- show trailing whitespaces
vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
vim.cmd('match ExtraWhitespace /\\s\\+$/')

vim.o.termguicolors = true
vim.opt.expandtab = false
vim.opt.smarttab = true
