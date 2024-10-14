# cmp-notmuch

[notmuch](https://notmuchmail.org/) address source for the following completion engines:

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [blink.cmp](https://github.com/Saghen/blink.cmp)

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
sources = {
    providers = {
        -- default providers
        { "blink.cmp.sources.lsp",      name = "LSP" },
        { "blink.cmp.sources.path",     name = "Path",     score_offset = 3 },
        { "blink.cmp.sources.snippets", name = "Snippets", score_offset = -3 },
        { "blink.cmp.sources.buffer",   name = "Buffer",   fallback_for = { "LSP" } },

        -- notmuch source
        { "blink.cmp.sources.notmuch",  name = "Notmuch" },
    },
}
```
