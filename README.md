# Dotfiles

╺┳┓┏━┓╺┳╸┏━╸╻╻  ┏━╸┏━┓
 ┃┃┃ ┃ ┃ ┣╸ ┃┃  ┣╸ ┗━┓
╺┻┛┗━┛ ╹ ╹  ╹┗━╸┗━╸┗━┛

Welcome to 'dotfiles'! 

This project sets up an opinionated user environment with the
aim of acheiving a similar user experience across MacOS and Linux.

## Disclaimer
If you find this configuration useful, steal the parts you like and leave the rest. I subscribe to the 
idea of a PDE (Personal Development Environment) and I encourage you to do the
same.

Many times I have tried these kinds of configurations by taking exact copies 
of other people's dotfiles and I have found that it never really works out.
The reason for this is that everyone has their own personal preferences and
workflow. I have found that the best way to get a good configuration is to
start from scratch and build it up from the ground up, only adding what you 
need. 

My recommendation is to fork this repo and make tweaks to it if you want something more personalised.

## Installation
The entire system is intended to be installed at the root of the home directory
in ~/.dotfiles, all of the paths in the configurations depend on this idea.

So installation is first simply to clone the repository into the home directory
```sh
git clone git@github.com:divanvisagie/dotfiles.git ~/.dotfiles
```

Then to run the installation script. 

** Note: ** This script is kind of buggy, what it does is try and install the 
dependencies for the detected OS and then it tries to create symlinks for the
dotfiles. It is not perfect and it is not guaranteed to work, but that is fine 
for a single user product, its better to keep things simple.

```sh
./install.sh
```
