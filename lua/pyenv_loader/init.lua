local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("BufReadPost", {
		pattern = "*.py",
		callback = function()
			local file, err = io.open(".python-version", "r")

			if err then
				print("Could not open python-version file.")
			end

			if file then
				local file_output = file:read("all")
				if not file_output then
					vim.notify("No contents on file")
				end
				local local_environment = file_output.gsub(file_output, "\n", "")
				file:close()

				if vim.v.shell_error ~= 0 then
					vim.notify("Could not load pyenv local venv")
				end

				local home_dir = os.getenv("HOME")
				local python_path = (home_dir .. "/.pyenv/versions/" .. local_environment .. "/bin/python3")

				if not vim.fn.exists(python_path) then
					vim.notify("Python 3 executable missing from pyenv path")
				end

				vim.g.python3_host_prog = python_path

				require("lspconfig").pyright.setup({
					settings = {
						python = {
							pythonPath = python_path,
						},
					},
				})
			end
		end,
	})
end

return M
