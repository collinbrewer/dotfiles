return {
  -- copy selected lines as url
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup()
    end,
  },

  -- lightweight git commands akin to vim-fugitive
  { "echasnovski/mini-git", version = "*", main = "mini.git" },

  -- line indicators
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    -- eys = require("mappings").gitsigns,
    config = function()
      require("gitsigns").setup()
    end,
  },

  {
    "FabijanZulj/blame.nvim",
    opts = {
      date_format = "%d.%m.%Y",
      virtual_style = "right_align",
      -- views = {
      --   window = false,
      --   virtual = true,
      --   default = true,
      -- },
      focus_blame = true,
      merge_consecutive = false,
      max_summary_width = 30,
      colors = nil,
      blame_options = nil,
      commit_detail_view = "vsplit",
      -- format_fn = formats.commit_date_author_fn,
      mappings = {
        commit_info = "i",
        stack_push = "<TAB>",
        stack_pop = "<BS>",
        show_commit = "<CR>",
        close = { "<esc>", "q" },
      },
    },
  },
}
