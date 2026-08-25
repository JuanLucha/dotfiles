# 1. Zero third-party plugins (Vanilla + Custom Lua)

Date: 2026-08-25

## Status

Accepted

## Context

We are rebuilding the Neovim configuration from scratch. Initially, the decision was to use built-in packages instead of a plugin manager. However, the requirement has been clarified: the goal is to not use any third-party plugins at all. Any required functionality will be implemented via custom Lua code tailored specifically to this configuration.

## Decision

We will build a 100% vanilla Neovim environment. We will not use `lazy.nvim`, built-in packages (`pack/`), or any external community plugins (e.g., no `nvim-lspconfig`, no `telescope`, no `treesitter` external parsers unless built-in). All custom behavior (statusline, fuzzy finding, LSP configuration) will be hand-coded using Neovim's native Lua API.

## Consequences

*   **Pros:** Absolute ownership of the codebase. Minimal overhead, zero external dependencies breaking on updates. Maximum educational value regarding Neovim's API.
*   **Cons:** We will need to write significantly more code for features normally taken for granted (like a nice statusline or LSP server attachment). We miss out on the collective bug fixes of the community plugins.
