return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- ensure_installed = { "lua", "vim", "go", "terraform", "python" },
        highlight = {
          enable = true
        },
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local _ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if _ok and stats and stats.size > max_filesize then
            return true
          end
        end
      }
    end,
  }
}
