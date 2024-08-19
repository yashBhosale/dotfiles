
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

require("lazy").setup({
	'neomake/neomake',
	'neovim/nvim-lspconfig',
	'Chiel92/vim-autoformat',
	{
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies={
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config=function()
      
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), 
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
          })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })
    end
  },
	
	{
    'folke/tokyonight.nvim', branch= 'main'
  },
	{
    'ms-jpq/chadtree', branch= 'chad', build= 'python3 -m chadtree deps'
  },
	{
	  'nvim-treesitter/nvim-treesitter', 
	  build=":TSUpdate",

    config = function () 
      require('nvim-ts-autotag').setup() 
    end

  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    'windwp/nvim-ts-autotag',
    event = "InsertEnter"
  },
  {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
  }
})
local root_files = {
	".git",
	"requirements.txt"
}

local lspconfig = require 'lspconfig'
local util = require 'lspconfig/util'
require('lspconfig').ruff_lsp.setup {
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  }
}
local on_attach = function(client, bufnr)
  if client.name == 'ruff_lsp' then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
end

lspconfig.ruff_lsp.setup {
  on_attach = on_attach,
}
lspconfig.pyright.setup{
  cmd = {"pyright-langserver", "--stdio"},
  filetypes={"python"},

  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { '*' }
      },
    },
  },
  root_dir = function(filename)
    return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
  end;
}

lspconfig.blueprint_ls.setup{}

local ts_plugin_path = '/home/yash/.nvm/versions/node/v20.12.0/lib/@vue/typescript-plugin'
lspconfig.tsserver.setup {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = ts_plugin_path,
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

lspconfig.volar.setup {}


