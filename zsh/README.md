# Zsh Setup
This requires the inallation of oh-my-zsh and powerline 10k

Since many setup wizards write stuff to the main zsh file, i have elected to
write only include files here that can then be simlinked to ~/.zsh and used by
.zshrc with the following code

```sh
for config_file ($HOME/.zsh/*.zsh); do
  source $config_file
done
```

## Installation

### Requires the following plugin to be installed
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
