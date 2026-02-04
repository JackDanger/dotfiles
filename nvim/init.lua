-- Modern Neovim Configuration
-- No Python dependencies, pure Lua

-- Set leader keys BEFORE loading lazy.nvim
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim and load plugins
require("config.lazy")

-- Load editor options
require("config.options")

-- Load keymaps after plugins (some depend on plugin commands)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.keymaps")
  end,
})
