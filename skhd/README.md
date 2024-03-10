# Skhd Configuration (MacOS)

Skhd is a MacOS program that allows you to execute bash commands when a specific
key combo is pressed. 

The use case for this is to allow full control over windows by using osascript
to select applications and manipulate windows.

The reason for doing this is that on MacOS, you then get a window management
system that can be duplicatied on Linux (using xbindkeys), and you get a window
management system that is independent of the Operating system.

Assigning specific shortcuts to specific applications also allows for a more
deterministic workflow compared to alt-tabbing through a list of open windows.
## Installation

```sh
brew install koekeishiya/formulae/skhd
brew services start skhd
```


