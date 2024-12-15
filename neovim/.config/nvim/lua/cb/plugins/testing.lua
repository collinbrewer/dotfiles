return {
  "nvim-neotest/neotest",
  dependencies = {
    "adrigzr/neotest-mocha",
    "nvim-neotest/neotest-jest",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      log_level = "info",
      adapters = {
        require("neotest-mocha")({
          command = "npx mocha --",
          -- cwd = function(path)
          --   return vim.fn.getcwd()
          -- end,
        }),

        require("neotest-jest")({}),
      },
      summary = {
        open = "botright vsplit | vertical resize 70"
      },
    })

    -- Key bindings with descriptions using vim.keymap.set
    vim.keymap.set(
      "n",
      "<leader>tt",
      ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
      { noremap = true, silent = true, desc = "Run tests in current file" }
    )
    vim.keymap.set(
      "n",
      "<leader>tT",
      ":lua require('neotest').run.run(vim.uv.cwd())<CR>",
      { noremap = true, silent = true, desc = "Run all tests" }
    )
    vim.keymap.set(
      "n",
      "<leader>tS",
      ":lua require('neotest').run.stop()<CR>",
      { noremap = true, silent = true, desc = "Stop running tests" }
    )
    vim.keymap.set(
      "n",
      "<leader>to",
      ":lua require('neotest').output.open({ enter = true, auto_close = true })<CR>",
      { noremap = true, silent = true, desc = "Show test output" }
    )
    vim.keymap.set(
      "n",
      "<leader>tO",
      ":lua require('neotest').output.toggle()<CR>",
      { noremap = true, silent = true, desc = "Toggle output panel" }
    )
    vim.keymap.set(
      "n",
      "<leader>tl",
      ":lua require('neotest').run.run_last()<CR>:lua require('neotest').output.open({ enter = false })<CR>",
      { noremap = true, silent = true, desc = "Rerun latest test and show output" }
    )
    vim.keymap.set(
      "n",
      "<leader>tr",
      ":lua require('neotest').run.run()<CR>",
      { noremap = true, silent = true, desc = "Run nearest test" }
    )
    vim.keymap.set(
      "n",
      "<leader>tw",
      ":lua require('neotest').watch.toggle(vim.fn.expand('%'))<CR>",
      { noremap = true, silent = true, desc = "Toggle watch" }
    )
    vim.keymap.set(
      "n",
      "<leader>ts",
      ":lua require('neotest').summary.toggle()<CR>",
      { noremap = true, silent = true, desc = "Toggle summary" }
    )
  end,
}
