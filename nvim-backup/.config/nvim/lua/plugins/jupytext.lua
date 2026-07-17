return {
	{
		"GCBallesteros/jupytext.nvim",
		lazy = false, -- load eagerly to ensure .ipynb files are handled
		config = function()
			require("jupytext").setup({
				style = "markdown",
				output_extension = "md",
				force_ft = "markdown",
			})
		end,
	},
}
