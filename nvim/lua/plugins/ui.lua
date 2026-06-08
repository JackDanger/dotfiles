-- UI: colorscheme, treesitter, statusline
return {
  -- Dichromatic colorscheme (your preference)
  {
    "romainl/vim-dichromatic",
    lazy = false,
    priority = 1000,
    config = function()
      -- dichromatic leaves popup-menu groups unreadable (black on black).
      -- Reapply on every colorscheme load so completion/wildmenu stay legible.
      local function fix_menu_colors()
        local set = vim.api.nvim_set_hl
        set(0, "Pmenu", { fg = "#ffffff", bg = "#005f87" })
        set(0, "PmenuSel", { fg = "#000000", bg = "#00afff" })
        set(0, "PmenuSbar", { bg = "#003f57" })
        set(0, "PmenuThumb", { bg = "#00afff" })
        set(0, "WildMenu", { fg = "#000000", bg = "#00afff" })
        -- nvim-cmp uses Pmenu but kind/abbr need explicit fg to be visible
        set(0, "CmpItemAbbr", { fg = "#ffffff" })
        set(0, "CmpItemAbbrMatch", { fg = "#00ffff", bold = true })
        set(0, "CmpItemMenu", { fg = "#9e9e9e" })
        set(0, "CmpItemKind", { fg = "#d7afff" })
      end
      vim.api.nvim_create_autocmd("ColorScheme", { callback = fix_menu_colors })
      vim.cmd.colorscheme("dichromatic")
      fix_menu_colors()
    end,
  },

  -- Treesitter: syntax highlighting and parser installation
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "go",
        "gomod",
        "gosum",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "ruby",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.config").setup(opts)
      -- Folding via treesitter
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  },

  -- Simple statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = false,
        theme = "auto",
        globalstatus = true,
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { { "filename", path = 1 }, "diagnostics" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = {},
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "neo-tree",
          "lazy",
          "mason",
        },
      },
    },
  },

  -- Better UI for inputs and selects
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
