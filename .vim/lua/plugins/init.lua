return {
  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "G" },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    lazy = false,
    config = true,
    keys = {
      { "gb", ":Gitsigns blame_line<CR>" },
    },
  },
  {
    "godlygeek/tabular",
    lazy = true,
    cmd = { "Tabularize" },
    init = function()
      vim.keymap.set("n", "<leader>a=", ":Tabularize /=<CR>")
      vim.keymap.set("v", "<leader>a=", ":Tabularize /=<CR>")
      vim.keymap.set("n", "<leader>a:", ":Tabularize /:\\zs=<CR>")
      vim.keymap.set("v", "<leader>a:", ":Tabularize /:\\zs=<CR>")
    end,
  },
  {
    "ledger/vim-ledger",
    ft = "ledger",
    init = function()
      vim.g.ledger_is_hledger = true
    end,
  },
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    version = false,
    config = true,
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },
  {
    "airpods69/yagp.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function(_, opts)
      require("copilot").setup(opts)
      local suggestion = require("copilot.suggestion")
      local function toggle_auto_trigger()
        local auto_trigg = vim.b.copilot_suggestion_auto_trigger
        if auto_trigg == nil or auto_trigg == true then
          vim.notify("Copilot auto-suggestion disabled")
          suggestion.dismiss()
        else
          vim.notify("Copilot auto-suggestion enabled")
          suggestion.next()
        end
        suggestion.toggle_auto_trigger()
      end
      vim.keymap.set("n", "<leader>cs", toggle_auto_trigger, { desc = "Copilot Suggestion Toggle" })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",           -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For working with files with slash commands
      {
        "stevearc/dressing.nvim",   -- Optional: Improves the default Neovim UI
        opts = {},
      },
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "gemini",
          },
          inline = {
            adapter = "copilot",
          },
          agent = {
            adapter = "copilot",
          },
        },
        adapters = {
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = "GEMINI_API_KEY",
              },
            })
          end,
        },
      })
    end,
  },
  {
    "ramilito/kubectl.nvim",
    config = function()
      require("kubectl").setup()
    end,
  },
}
