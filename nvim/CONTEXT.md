# Neovim Configuration Context

## Terminology & Architecture

*   **Vanilla Core:** We strictly use Neovim's built-in Lua API. No external dependencies, package managers, or third-party plugins.
*   **Modular Architecture:** The configuration is split into distinct domains under the `lua/` directory.
*   **Core Settings (`lua/core/`):** Fundamental editor behavior. Includes `options` (vim.opt), `keymaps` (vim.keymap), and `autocmds` (vim.api.nvim_create_autocmd).
*   **UI Components (`lua/ui/`):** Custom visual elements, such as hand-coded statuslines or tablines.

