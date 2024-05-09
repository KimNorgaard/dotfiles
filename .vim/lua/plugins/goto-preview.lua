local config = function()
	require("goto-preview").setup({
		default_mappings = true,
	})
end

return {
	{
		"rmagatti/goto-preview",
		config = config,
	},
}
