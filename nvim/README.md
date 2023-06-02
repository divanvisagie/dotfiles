# Custom Neovim Setup
As someone who has tried out neovim multiple times I, the one time I stuck with 
it was when I stopped taking other configs and built one myself. I thin neovim
is only really useful if you use it to build up your own personal development
environment. 


This neovim config was built from scratch following the video below, I then 
customised it to my liking and personal needs but the main point is to not ever
have plugins installed if you dont know what they do and havent written the 
keybindings yourself. You dont want an editor with features you don't want in
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
