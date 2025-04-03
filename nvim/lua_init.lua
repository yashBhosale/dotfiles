
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

local function get_venv(variable)
  local venv = os.getenv(variable)
  if venv ~= nil and string.find(venv, "/") then
    local orig_venv = venv
    for w in orig_venv:gmatch("([^/]+)") do
      venv = w
    end
    venv = string.format("%s", venv)
  end
  return venv
end

local function get_venvs()
  local venv = get_venv("CONDA_DEFAULT_ENV") or get_venv("VIRTUAL_ENV") or "NO ENV"
  if venv ~= "NO ENV" and string.len(venv) > 10 then
    venv = string.sub(venv, 1, 10)
  end
  return " " .. venv
end

require("lazy").setup("plugins")
require("config.keymaps")
require("config.lsp")
require("dap-python").setup("python3")

local root_files = {
	".git",
	"requirements.txt"
}



require('lualine').setup{
   sections = {
     lualine_a = {
       'mode',
       get_venvs
     },
     lualine_x = {
       'filetype'
     }
   }
}
