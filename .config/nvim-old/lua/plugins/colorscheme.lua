return {
  {
    "KimNorgaard/nvim-moonwalk",
    priority = 1000,
    lazy = false,
    config = function()
      vim.opt.background = "light"
      -- vim.cmd([[colorscheme moonwalk]])
    end,
  },
  {
    "KimNorgaard/munu",
    lazy = true,
    name = "munu",
    config = function()
      vim.opt.background = "dark"
    end,
  },
  {
    "aliqyan-21/darkvoid.nvim",
    name = "darkvoid",
    lazy = true,
    config = function()
      vim.opt.background = "dark"
    end,
  },
  {
    "slugbyte/lackluster.nvim",
    -- name = "lackcluster",
    lazy = true,
    -- config = function()
    --   vim.opt.background = "dark"
    -- end,
  },
}
