return {
  {
    "fenetikm/falcon",
    lazy = true,
    name = "falcon",
    config = function()
      vim.opt.background = "dark"
      vim.api.nvim_set_var("falcon.palette", {
        red = "#ff3600",
        orange = "#ff761a",
        yellow = "#ffc552",
        green = "#718e3f",
        blue_gray = "#99a4bc",
        purple = "#635196",
        indigo = "#5521d9",
        status = "#28282d",
        status_2 = "#36363a",
        inactive_status = "#1c1c22",
        black = "#000004",
        white = "#F8F8FF",
        light_gray = "#dfdfe5",
        normal_gray = "#b4b4b9",
        mid_gray = "#787882",
        mid_dark_gray = "#57575e",
        dark_gray = "#36363a",
        modified = "#c8d0e3",
        branch = "#99a4bc",
        method = "#a1968a",
        path = "#787882",
        info = "#787882",
        hint = "#847b73",
        error = "#9e1e00",
        warning = "#bc8f3f",
      })
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
    "dundargoc/fakedonalds.nvim",
  },
  { "sainnhe/gruvbox-material" },
  {
    "theJian/nvim-moonwalk",
    priority = 1000,
    lazy = false,
    config = function()
      vim.opt.background = "light"
      vim.cmd([[colorscheme moonwalk]])
    end,
  },
  {
    "savq/melange-nvim",
    lazy = true,
    config = function()
      vim.opt.background = "dark"
      vim.cmd([[colorscheme melange]])
    end,
  },
}
