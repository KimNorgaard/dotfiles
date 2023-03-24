local function is_null_ls_formatting_enabed(bufnr)
    local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local generators = require("null-ls.generators").get_available(
        file_type,
        require("null-ls.methods").internal.FORMATTING
    )
    return #generators > 0
end

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
      if
          client.name == "null-ls" and is_null_ls_formatting_enabed(bufnr)
          or client.name ~= "null-ls"
      then
          vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
          vim.keymap.set("n", "<leader>gq", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
      else
          vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
      end
  end
end

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions

      null_ls.setup({
        sources = {
          -- python
          formatting.black.with { extra_args = { "--fast" } },
          formatting.isort,
          formatting.autoflake,
          diagnostics.flake8,
          diagnostics.yamllint,
          diagnostics.jsonlint,
          -- lua
          formatting.stylua,
          -- golang
          formatting.gofmt,
          formatting.gofumpt,
          formatting.goimports,
          formatting.goimports_reviser,
          diagnostics.staticcheck,
          -- terraform
          formatting.terraform_fmt,
          -- shell
          formatting.shfmt,
          formatting.beautysh,
          diagnostics.shellcheck,
          -- ansible
          diagnostics.ansiblelint,
          -- javascript
          formatting.eslint,
          diagnostics.eslint,
          -- general
          formatting.prettier,
          -- prose
          diagnostics.proselint.with({
              filetypes = { "markdown", "tex", "text", "mail" }
          }),
        },

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
        on_attach = on_attach,
      })
    end
  }
}
