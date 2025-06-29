To find desktop files in the system

```sh
ls /usr/share/applications/*.desktop
```

To set zen to the default browser

```bash
xdg-settings set default-web-browser app.zen_browser.zen.desktop
```
```bash
xdg-settings set default-web-browser com.brave.Browser.desktop
```

To set background
```bash
exec_always swaybg -i ~/.dotfiles/wallpapers/unix.jpg -m fill
```
Set default file browser
```bash
xdg-mime default com.system76.CosmicFiles.desktop inode/directory
```

