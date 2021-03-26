local lspconfig = require 'lspconfig'
local util = require'lspconfig/util'

local root_files = {
".git",
"requirements.txt"
}

lspconfig.pyright.setup{
  cmd = {"pyright-langserver", "--stdio"},
  filetypes={"python"},

  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true
      },
    },
  },
  root_dir = function(filename)
    return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
  end;
}

