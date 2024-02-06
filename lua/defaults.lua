vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.keymap.set('n', '<space>fE', '<cmd>NvimTreeOpen<cr>', {desc = 'Open NvimTree in home dir'})
vim.keymap.set('n', '<space>fq', '<cmd>NvimTreeClose<cr>', {desc = 'Close NvimTree if opened'})
vim.keymap.set('n', '<space>fe', '<cmd>NvimTreeOpen .<cr>', {desc = 'Open NvimTree in current dir'})
vim.keymap.set('n', '<space>fc', '<cmd>NvimTreeOpen ~/.config/nvim/<cr>', {desc = 'Save'})
vim.keymap.set('n', '<space>fc', '<cmd>NvimTreeOpen ~/.config/nvim/<cr>', {desc = 'Save'})
vim.keymap.set('n', '<space>mp', '<cmd>AsyncRun CHROME_PATH="/Applications/Yandex.app" marp % --preview<cr>', {desc = 'Open Marp preview'})

vim.keymap.set('n', '<space>q', '<cmd>q<cr>', {desc = 'Quit buffer'})
vim.keymap.set('n', '<space>w', '<cmd>w!<cr>', {desc = 'Write buffer'})

local augroup = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = augroup,
  desc = 'Use q to close the window',
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = {'*.pdf'},
  group = augroup,
  desc = 'Open pdfs in viewer',
  command = 'execute "!open %" | q!',
})
