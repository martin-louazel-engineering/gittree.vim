gittree.vim
======

Yet another git commit browser, heavily inspired by junegunn's [gv.vim](https://github.com/junegunn/gv.vim)

Motivation
------------

I was previously using some custom wrapper function around [vim-futigive](https://github.com/tpope/vim-fugitive)'s `:Git log`, which was nice and very extendable, but this has the issue of being quite slow, especially for bigger repositories.
I encountered [gv.vim](https://github.com/junegunn/gv.vim), that was remarkably faster than the previous option, since it was directly running the git log command as a shell command via `read!`. However, I found that the lack of customisation option was quite a shame, plus I didn't like the mapping once inside the buffer.
So this plugin is kind of a merging of these 2 approach: using gv's very fast display of the git history, combined with fugitive's mappings and my custom wrapper functions.

Installation
------------

Requires fugitive.

Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'tpope/vim-fugitive'
Plug 'martin-louazel-engineering/gittree.vim'
```

Usage
-----

### Commands

- `:GT` to open commit browser
    - You can pass `git log` options to the command, e.g. `:GT -S foobar -- plugins`.

### Mappings

- `o` or `<cr>` on a commit to display the content of it in a vim split
- `<leader>gc` on a line to check its commit out
- `<leader>gp` on a line to cherry-pick its commit
- `<leader>gr` on a line to revert its commit
- `<leader>gr` on a line to create a patch file with its commit
- `<leader>gs` to run git switch on whatever is under the cursor (ie branch/commit/tag)
- `<leader>gm` to run git merge on whatever is under the cursor

Customization
-------------

No customization is available for the moment, I will maybe extend the plugin later to allow for a somewhat arbitrary git log format...
