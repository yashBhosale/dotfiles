local lspconfig = require 'lspconfig'
local util = require 'lspconfig/util'
require('lspconfig').ruff.setup {
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  }
}
local on_attach = function(client, bufnr)
  if client.name == 'ruff' then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
end

lspconfig.ruff.setup {
  on_attach = on_attach,
}

local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
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

-- local ts_plugin_path = '/home/yash/.nvm/versions/node/v20.12.0/lib/@vue/typescript-plugin'
-- lspconfig.tsserver.setup {
--   init_options = {
--     plugins = {
--       {
--         name = '@vue/typescript-plugin',
--         location = ts_plugin_path,
--         languages = { 'vue' },
--       },
--     },
--   },
--   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
-- }

lspconfig.volar.setup {}

