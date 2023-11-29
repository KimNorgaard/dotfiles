return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "nvimtools/none-ls.nvim",
  },
  config = function()
      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config

      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      local servers = { 'gopls', 'pyright' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = lsp_defaults.capabilities,
          on_attach = on_attach,
        }
      end
  end,
}
