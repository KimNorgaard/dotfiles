return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  opts =  {
    run_in_floaterm = false,
    lsp_codelens = false,
    lsp_inlay_hints = {
      enable = false,
    },
    luasnip = true,
  },
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
}
