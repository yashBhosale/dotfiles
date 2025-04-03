local nvimTreeApi = require("nvim-tree.api")
vim.keymap.set('n', '<leader>o', nvimTreeApi.tree.open)
vim.keymap.set('n', '<leader>c', nvimTreeApi.tree.close)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

require('Comment').setup()
local comment_api = require('Comment.api')
vim.keymap.set('n', '<C-_>', comment_api.toggle.linewise.current)
vim.keymap.set('x', '<C-_>', comment_api.toggle.linewise.current)
