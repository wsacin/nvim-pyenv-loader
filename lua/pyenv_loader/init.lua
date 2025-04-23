local M = {}

function M.setup(opts)
	print("something")
	local opts = opts or {}
	vim.api.nvim_create_autocmd("BufReadPost", {
		pattern = "*.py",
		callback = function()
			print("evaluating local pyenv-virtualenv")

			local file, err = io.open(".python-version", "r")

			if err then
				print("Could not open python-version file.")
			end

			if file then
				local local_environment = file:read("all")
				if not local_environment then
					print("No contents on file")
				end
				file:close()
				local out = vim.fn.system({
					"bash",
					"/home/wsobral/.config/nvim/lua/custom/plugins/pyenv_loader/activate_pyenv_version.sh",
					local_environment,
				})

				if vim.v.shell_error ~= 0 then
					print("Could not load pyenv local venv" .. out)
				end
			end
		end,
	})
end

return M
