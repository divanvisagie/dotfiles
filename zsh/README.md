# Zsh Setup

Since many setup wizards write stuff to .zshrc, I have elected to implement my zshrc setup
as a separate file that will be loaded in with the following automatic loading code:

```sh
for config_file ($HOME/.zsh/*.zsh); do
  source $config_file
done
```

The `install.sh` file in this directory will write this code to the end of your `.zshrc` file.


