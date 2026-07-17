return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true, -- Set to true if you want transparency
      custom_highlights = function(colors)
        return {
          -- Make statusline stand out
          StatusLine = { bg = colors.surface0, fg = colors.text },  -- Active statusline
          StatusLineNC = { bg = colors.mantle, fg = colors.subtext0 },  -- Inactive statusline
        }
      end,
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`): 
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
      },
      lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        inlay_hints = {
          background = true,
        },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        telescope = true,
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    })
    
    -- Set the colorscheme
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
