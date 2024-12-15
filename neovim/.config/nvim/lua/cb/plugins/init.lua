return {

  -- remap filetypes
  {
    "nathom/filetype.nvim",
    config = function()
      require("filetype").setup({
        overrides = {
          extensions = {
            es6 = "javascript",
          },
        },
      })
    end,
  },

  -- logging utility
  {
    "PatschD/zippy.nvim",
    config = function()
      vim.keymap.set("n", "<leader>lg", "<cmd>lua require('zippy').insert_print()<cr>")
    end,
  },

  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "pandoc.markdown", "rmd" },
    build = "cd app && npx --yes yarn install",
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
    },
    config = function()
      require("codecompanion").setup({
        display = {
          diff = {
            provider = "mini_diff",
          },
        },
        opts = {
          log_level = "DEBUG",
        },
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "cmd:op read op://personal/OpenAI/credential --no-newline",
              },
            })
          end,
        },
      })
    end,
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    requires = "neovim/nvim-lspconfig",
    opts = function()
      return {
        -- Your configuration here
        -- highlight = true,
        -- separator = ' > ',
        -- depth_limit = 0,
        -- depth_limit_indicator = "..",
        separator = " ",
        highlight = true,
        depth_limit = 5,
        -- icons = LazyVim.config.icons.kinds,
        lazy_update_context = true,
      }
    end,
  },
}
