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
  -- "sheerun/vim-polyglot",
}
