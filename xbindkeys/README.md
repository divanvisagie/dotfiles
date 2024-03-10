# Xbindkeys Configuration (Linux)

Xbindkeys is a Linux X window system program that allows you to execute bash 
commands when a specific key combo is pressed. 

The use case for this is to allow full control over windows by using a 
combination of wmctrl and xdotool to move, resize, and focus windows.

The reason for doing this is that on Linux, you then get a window management 
system that is independent of Desktop Environment and if you apply the same
on MacOS (using skhd), you get a window management system that is independent of the
Operating system.

Assigning specific shortcuts to specific applications also allows for a more 
deterministic workflow compared to alt-tabbing through a list of open windows.

## Restart when config has changed

```sh
pkill xbindkeys && xbindkeys
```

## Find conflicts
```sh
gsettings list-recursively | grep '<Super>s'
```

