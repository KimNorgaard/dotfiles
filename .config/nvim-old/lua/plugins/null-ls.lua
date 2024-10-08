local function is_null_ls_formatting_enabed(bufnr)
  local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local generators =
    require("null-ls.generators").get_available(file_type, require("null-ls.methods").internal.FORMATTING)
  return #generators > 0
end

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    if client.name == "null-ls" and is_null_ls_formatting_enabed(bufnr) or client.name ~= "null-ls" then
      vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
      vim.keymap.set("n", "<leader>gq", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
    else
      vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
    end
  end
end

return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "gbprod/none-ls-shellcheck.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = {}
      table.insert(opts.sources, nls.builtins.formatting.stylua)
      table.insert(opts.sources, nls.builtins.formatting.isort)
      table.insert(opts.sources, nls.builtins.formatting.black.with({ extra_args = { "--fast" } }))
      table.insert(opts.sources, nls.builtins.formatting.terraform_fmt)
      table.insert(opts.sources, nls.builtins.formatting.shfmt)
      table.insert(opts.sources, nls.builtins.formatting.prettier)
      table.insert(opts.sources, nls.builtins.diagnostics.yamllint)
      table.insert(opts.sources, nls.builtins.diagnostics.staticcheck)
      table.insert(
        opts.sources,
        nls.builtins.diagnostics.vale.with({
          filetypes = { "markdown", "tex", "text", "mail" },
        })
      )
      opts.on_attach = on_attach
    end,
    -- config = function()
    --   local nls = require("null-ls")
    --
    --   -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
    --   nls.register(require("none-ls-shellcheck.diagnostics"))
    --   nls.register(require("none-ls-shellcheck.code_actions"))
    --   require("null-ls").setup()
    -- end,
  },
}
