local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- disable netrw at the very start of your init.lua
vim.loaded_netrw = 1
vim.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("lazy").setup({
    "nvim-lua/plenary.nvim",
    "neanias/everforest-nvim",
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
    "skywind3000/asyncrun.vim",
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
})


require("nvim-treesitter.install").compilers = { "gcc-13" }
require("everforest").load()
require("nvim-web-devicons")
require("nvim-tree").setup()


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Find file in cwd"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "Grep in cwd"})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Search buffers"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "Search help"})
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {desc = "Search recent"})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "python"},
  auto_install = true,
  highlight = {
    enable = true,
  },
}

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
        --- in this function you can setup
        --- the language server however you want. 
        --- in this example we just use lspconfig

        require('lspconfig').lua_ls.setup({
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                  'vim',
                  'require'
                },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false,
              },
            },
          },
        })
        end,
    pyright = function()
        --- in this function you can setup
        --- the language server however you want. 
        --- in this example we just use lspconfig

        require('lspconfig').pyright.setup({
          python = {
              analysis = {
                  extraPaths = {"/Users/severovv/arcadia/"}
              }
          },
        })
        end,
    },
})

