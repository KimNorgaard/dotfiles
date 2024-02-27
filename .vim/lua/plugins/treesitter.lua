local config = function(_, opts)
  require("nvim-treesitter.configs").setup(opts)
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",
  config = config,
  opts = {
    -- ensure_installed = { "lua", "vim", "go", "terraform", "python" },
    highlight = {
      enable = true,
      disable = function(lang, buf)
        -- if lang == "go" then
        --   return true
        -- end
        local max_filesize = 1 * 1024 * 1024 -- 1 MB
        local _ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if _ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
  },
}
