# nvim-pyenv-loader

A simple plugin that sets the python interpreter based 
on the local pyenv file. It sets the executable path for:

1. Neovim's `g:python3_host_prog` (this is used by the healthcheck).
2. Pyright's `pythonPath` via lspconfig.
