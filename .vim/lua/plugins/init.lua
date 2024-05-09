return {
  {
    "tpope/vim-repeat",
    lazy = true,
    vent = "VeryLazy",
  },
  {
    "tpope/vim-surround",
    keys = { "ds", "cs", "ys", { "S", mode = "v" }, { "gS", mode = "v" } },
  },
  "tpope/vim-endwise",
  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "G" },
  },
  "pangloss/vim-simplefold",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  "BurntSushi/ripgrep",
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
    "voldikss/vim-floaterm",
    init = function()
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_height = 0.9
      vim.g.floaterm_keymap_toggle = "<leader>gt"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      vim.g.indent_blankline_use_treesitter = true
      -- require("indent_blankline").setup({
      --     show_current_context = true,
      --     show_current_context_start = true,
      -- })
    end,
  },
  -- {
  --   "vimwiki/vimwiki",
  --   branch = "dev",
  --   keys = {
  --     "<leader>ww",
  --     "<leader>ws",
  --     "<leader>w<leader>w",
  --   },
  --   init = function()
  --     -- vim.g.vimwiki_custom_wiki2html = "~/vimwiki/vimwiki/wiki2html.py"
  --     vim.g.vimwiki_global_ext = 0
  --     vim.g.vimwiki_list = {
  --       {
  --         path = "~/vimwiki",
  --         syntax = "markdown",
  --         ext = ".md",
  --         template_path = "~/vimwiki/templates",
  --       },
  --     }
  --     vim.g.vimwiki_folding = "expr"
  --   end,
  -- },
  "sheerun/vim-polyglot",
  {
    "rodjek/vim-puppet",
    ft = "puppet",
  },
  {
    "ledger/vim-ledger",
    ft = "ledger",
    init = function()
      vim.g.ledger_is_hledger = true
    end,
  },
  {
    "hashivim/vim-terraform",
    ft = "terraform",
  },
  "vim-pandoc/vim-pandoc-syntax",
}
