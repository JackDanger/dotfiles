-- Modern Neovim Configuration
-- No Python dependencies, pure Lua

-- Disable netrw (using neo-tree instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader keys BEFORE loading lazy.nvim
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Compatibility shim: ft_to_lang removed in Neovim 0.10+
if vim.treesitter.language and not vim.treesitter.language.ft_to_lang then
  vim.treesitter.language.ft_to_lang = function(ft)
    local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
    return ok and lang or ft
  end
end

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
