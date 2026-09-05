# Neovim cheatsheet

Leader is Space. Everything not listed here is stock Neovim.

## LSP (built-in, `:h lsp-defaults`)

| Key | Action |
|-----|--------|
| `K` | Hover docs |
| `<C-]>` | Go to definition (`<C-t>` to jump back) |
| `grr` | References |
| `gri` | Implementation |
| `grt` | Type definition |
| `grn` | Rename |
| `gra` | Code action (normal and visual) |
| `grx` | Run code lens |
| `gO` | Document symbols |
| `gq` | Format (motion or visual selection) |
| `<C-s>` | Signature help (insert mode) |
| `]d` `[d` | Next / previous diagnostic |
| `<C-w>d` | Show diagnostic under cursor |

## Completion (blink.cmp)

| Key | Action |
|-----|--------|
| `<Tab>` `<S-Tab>` | Next / previous item (also `<C-n>` / `<C-p>`) |
| `<CR>` | Accept selected item (plain newline if nothing selected) |
| `<C-e>` | Close menu |
| `<C-space>` | Open menu / toggle docs |
| `<C-b>` `<C-f>` | Scroll docs |
| `<C-k>` | Toggle signature help |

Inside a snippet, `<Tab>` / `<S-Tab>` jump between fields once the menu is closed.

## Telescope

| Key | Action |
|-----|--------|
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep |
| `<Space>fb` | Buffers |
| `<Space>fh` | Help tags |

Inside a picker: `<C-n>`/`<C-p>` move, `<CR>` open, `<C-x>` split,
`<C-v>` vsplit, `<C-q>` send all results to quickfix, `<C-/>` show all
picker keys, `<Esc>` close. Any other picker: `:Telescope <Tab>`.

## Files (oil)

| Key | Action |
|-----|--------|
| `-` | Open parent directory as a buffer |
| `<CR>` | Open entry |
| `g?` | Show all oil keys |

Edit the listing like text (rename, `dd` to delete, `o` to add) and `:w`.

## Git (fugitive)

`:G` for status, `:G blame`, `:G log`, `:Gdiffsplit`. In the status buffer:
`s` stage, `u` unstage, `cc` commit, `=` toggle diff, `g?` help.

## Custom

| Key | Action |
|-----|--------|
| `<Space>kj` | Yank whole file to clipboard |
| `<Esc>` | Leave terminal mode (in `:terminal`) |
