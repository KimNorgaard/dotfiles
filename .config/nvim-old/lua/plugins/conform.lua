return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "FormatEnable", "FormatDisable" },
  keys = {
    {
      "<leader>bf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "x", "o" },
      desc = "Format buffer",
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
        vim.notify("Autoformat disabled for this buffer", "info", { title = "Conform" })
      else
        vim.g.disable_autoformat = true
        vim.notify("Autoformat disabled", "info", { title = "Conform" })
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
      vim.notify("Autoformat enabled", "info", { title = "Conform" })
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
  opts = {
    formatters_by_ft = {
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
    },
    format_on_save = function(bufnr)
      local ignore_filetypes = { "html", "go" }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return { timeout_ms = 500, lsp_fallback = true }
    end,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
