local M = {}

function M.map(mode, lhs, rhs, opts)
  local final_opts = {}
  if type(opts) == "string" then
    final_opts.desc = opts
  elseif type(opts) == "table" then
    final_opts = opts
  end
  vim.keymap.set(mode, lhs, rhs, final_opts)
end

return M
