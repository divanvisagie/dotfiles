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

### Install the required LSP servers

```sh
brew install lua-language-server
brew install rust-analyzer
cargo install --locked --git https://github.com/Feel-ix-343/markdown-oxide.git markdown-oxide
deno upgrade
npm install -g @vtsls/language-server
npm install -g typescript typescript-language-server
```


## Troubleshooting
For issues with treesitter try:
```vim
:TSInstall typescript
:TSInstallSync typescript
```
On linux for rust debugging
```sh
sudo setcap cap_sys_ptrace=eip /usr/lib/llvm-14/bin/lldb-vscode
echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
```
