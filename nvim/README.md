# Custom Neovim Setup
As someone who has tried out neovim multiple times I, the one time I stuck with 
it was when I stopped taking other configs and built one myself. I think neovim
is only really useful if you use it to build up your own personal development
environment. 

This neovim config was built from scratch following the video below, I then 
customised it to my liking and personal needs. The main point is to not ever
have plugins installed if you don't know what they do and haven't written the 
keybindings yourself. You don't want an editor with features you don't want in
the first place.

[![0 to LSP : Neovim RC From Scratch](https://img.youtube.com/vi/w7i4amO_zaE/0.jpg)](https://www.youtube.com/watch?v=w7i4amO_zaE)

## Hints

#### Reformatting a file with new indents:
```vim
:set tabstop=4
:set shiftwidth=4
:set expandtab
:normal gg=G
```

## Installing

The initial setup is meant to be cloned to `~/.dotfiles`, you can then use `install.sh` to create
a symbolic link that will point to this config.

Once that is sorted out, browse to the packer.lua and then enter the following vim commands:

```vim
:so
:PackerSync
```
