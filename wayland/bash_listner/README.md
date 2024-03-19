# Bash Listner

Bash Listner is a replacement for XBindkeys on wayland, it uses libinput to listen to the keyboard
in order to execute commands.

```sh
sudo usermod -aG input yourusername
```


Creating a udev rule involves creating a file in /etc/udev/rules.d/ (e.g., 99-input.rules) with contents along the lines of:
```makefile
ACTION=="add", KERNEL=="event*", SUBSYSTEM=="input", MODE="660", GROUP="input"
```

# setup
```sh
sudo apt install libdbus-1-dev
```
