# cmp-notmuch

[notmuch](https://notmuchmail.org/) address source for the following completion engines:

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [blink.cmp](https://github.com/Saghen/blink.cmp)

## Dependencies

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

## Install

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ "michaeladler/cmp-notmuch", dependencies = "nvim-lua/plenary.nvim" },
```

## Setup

### nvim-cmp

```lua
require('cmp').setup {
  sources = {
    { name = 'notmuch' }
  }
}
```

### blink.cmp

```lua
-- ...

sources = {
    completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer", "notmuch" },
    },
    providers = {
        lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
        },
        path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 3,
        },
        snippets = {
            name = "Snippets",
            module = "blink.cmp.sources.snippets",
            score_offset = -3,
        },
        buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            fallback_for = { "lsp" },
        },
        notmuch = {
            name = "Notmuch",
            module = "blink.cmp.sources.notmuch",
        },
    },
},

-- ...
```
