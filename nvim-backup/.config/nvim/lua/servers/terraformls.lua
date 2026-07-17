-- ================================================================================================
-- TITLE : terraformls (Terraform Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/hashicorp/terraform-ls
-- ================================================================================================
--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config('terraformls', {
		capabilities = capabilities,
		filetypes = { "terraform", "tf", "hcl" },
		settings = {
			terraform = {
				-- Enable experimental features if needed
				experimentalFeatures = {
					validateOnSave = true,
					prefillRequiredFields = true,
				},
			},
		},
	})

	-- Auto-format on save
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = { "*.tf", "*.tfvars" },
		callback = function()
			vim.lsp.buf.format({ async = false })
		end,
	})
end
