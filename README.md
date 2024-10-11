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
        {
            { "blink.cmp.sources.lsp" },
            { "blink.cmp.sources.path" },
            { "blink.cmp.sources.snippets", score_offset = -3 },
            -- provided by this repo
            { "blink.cmp.sources.notmuch" },
        },
        { { "blink.cmp.sources.buffer" } },
    },
}
```
