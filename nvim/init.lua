require("packer").startup(function()
  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/nvim-cmp")
  use("nvim-lua/lsp_extensions.nvim")
  use("simrat39/symbols-outline.nvim")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("gruvbox-community/gruvbox")
  use("olimorris/onedarkpro.nvim")
  use("onsails/lspkind-nvim")
  use("nvim-treesitter/nvim-treesitter", {
    run = ":TSUpdate"
  })
end)

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "typescript", "tsx", "javascript" },
  auto_install = true,
  highlight = {
    enable = true,
  },
}

require'lspconfig'.tsserver.setup {}

local cmp = require'cmp'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.scroll_docs(-4),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }
})

vim.api.nvim_set_keymap('n', 'ff', ':Telescope git_files<Cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'fg', ':Telescope live_grep<Cr>', {noremap = true, silent = true})
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.errorbells = false
vim.opt.tabstop = 2 
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.mapleader = " "

require("onedarkpro").setup({
  dark_theme = "onedark_vivid", -- The default dark theme
  light_theme = "onelight", -- The default light theme
  colors = {}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
  highlights = {}, -- Override default highlight groups
  ft_highlights = {}, -- Override default highlight groups for specific filetypes
  plugins = { -- Override which plugin highlight groups are loaded
    -- See the Supported Plugins section for a list of available plugins
  },
  styles = { -- Choose from "bold,italic,underline"
      strings = "NONE", -- Style that is applied to strings.
      comments = "NONE", -- Style that is applied to comments
      keywords = "NONE", -- Style that is applied to keywords
      functions = "NONE", -- Style that is applied to functions
      variables = "NONE", -- Style that is applied to variables
      virtual_text = "NONE", -- Style that is applied to virtual text
  },
  options = {
      bold = false, -- Use the colorscheme's opinionated bold styles?
      italic = false, -- Use the colorscheme's opinionated italic styles?
      underline = false, -- Use the colorscheme's opinionated underline styles?
      undercurl = false, -- Use the colorscheme's opinionated undercurl styles?
      cursorline = false, -- Use cursorline highlighting?
      transparency = true, -- Use a transparent background?
      terminal_colors = false, -- Use the colorscheme's colors for Neovim's :terminal?
      window_unfocused_color = false, -- When the window is out of focus, change the normal background?
  }
})

vim.api.nvim_command [[colorscheme onedarkpro]]
