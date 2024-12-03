return {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent_background = true,
	},
	config = function()
		vim.cmd("colorscheme catppuccin")
		require("catppuccin").setup({
			flavour = "mocha",
			background = {
				dark = "mocha",
			},
			transparent_background = true,
			show_end_of_buffer = false,
			term_colors = false,
			styles = {
				comments = { "italic" },
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				treesitter = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
		})
	end,
}
