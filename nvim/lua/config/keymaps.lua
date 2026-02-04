-- Keymaps (ported from vimrc + modern additions)
local map = vim.keymap.set

-- Escape with jj
map("i", "jj", "<ESC>", { desc = "Escape insert mode" })

-- Save shortcuts
map("n", ";;", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<C-e>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-e>", "<ESC><cmd>w<CR>", { desc = "Save and exit insert" })

-- Command typo fixes
vim.cmd([[
  command! W w
  command! Wq wq
  command! WQ wq
  command! Q q
]])
map("n", "EE", "<cmd>e!<CR>", { desc = "Reload file" })
map("n", "QQ", "<cmd>q!<CR>", { desc = "Force quit" })

-- Clear search highlight
map("n", "<leader>h", "<cmd>nohl<CR>", { desc = "Clear search highlight" })

-- Better window navigation (when not using tmux-navigator)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Quickfix navigation (your @n/@p mappings)
map("n", "@n", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "@p", "<cmd>cprevious<CR>", { desc = "Previous quickfix" })
map("n", "<leader>q", "<cmd>copen<CR>", { desc = "Open quickfix" })
map("n", "<leader>Q", "<cmd>cclose<CR>", { desc = "Close quickfix" })

-- Scroll keeping cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Prev search centered" })

-- Visual mode search/replace (your C-r mapping)
map("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', { desc = "Replace selection" })

-- Toggle scrolloff (your leader-o mappings)
map("n", "<leader>o", "<cmd>set scrolloff=99999<CR>", { desc = "Center cursor always" })
map("n", "<leader>O", "<cmd>set scrolloff=8<CR>", { desc = "Normal scrolloff" })

-- Break line on comma
map("n", "<leader>,", "f,a<CR><ESC>", { desc = "Break line at comma" })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Use LSP for Ctrl+] instead of tags (go to definition)
map("n", "<C-]>", vim.lsp.buf.definition, { desc = "Go to definition (LSP)" })

-- LSP info shortcut (replacement for deprecated :LspInfo)
map("n", "<leader>li", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP clients attached")
    return
  end
  for _, client in ipairs(clients) do
    print(string.format("LSP: %s (root: %s)", client.name, client.config.root_dir or "none"))
  end
end, { desc = "LSP info" })

-- Restore cursor position on file open
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-resize splits on window resize
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =")
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
