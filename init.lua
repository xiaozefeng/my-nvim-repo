-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

require('basic')
require('plugins')
require('keybindings')
require('colorscheme')
require('plugin-config.toggleterm')
-- require('lsp')
-- require("plugin-config.dashboard")
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")
require("format.setup")
