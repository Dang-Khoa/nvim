return {
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			{ "hrsh7th/nvim-cmp" },
		},
		cmd = "Copilot",
		event = "InsertEnter",
		build = ":Copilot auth",
		opts = {
			panel = {
				enabled = true,
				auto_refresh = true,
			},
			suggestion = {
				enabled = true,
				-- use the built-in keymapping for "accept" (<M-l>)
				auto_trigger = true,
				accept = false, -- disable built-in keymapping
			},
			filetypes = {},
		},
		config = function(_, opts)
			require("copilot").setup(opts)

			-- hide copilot suggestions when cmp menu is open
			-- to prevent odd behavior/garbled up suggestions
			local cmp_status_ok, cmp = pcall(require, "cmp")
			if cmp_status_ok then
				cmp.event:on("menu_opened", function()
					vim.b.copilot_suggestion_hidden = true
				end)

				cmp.event:on("menu_closed", function()
					vim.b.copilot_suggestion_hidden = false
				end)
			end
		end,
	},
	{
		{
			"CopilotC-Nvim/CopilotChat.nvim",
			branch = "canary",
			dependencies = {
				{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
				{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
			},
			opts = {
				debug = true, -- Enable debugging
				-- See Configuration section for rest
			},
			keys = {
				{
					"<leader>cc",
					"<cmd>CopilotChatToggle<cr>",
					desc = "Toggle Copilot Chat",
				},
			},
			window = {
				layout = "float",
			},
			-- See Commands section for default commands if you want to lazy load on them
		},
	},
}
