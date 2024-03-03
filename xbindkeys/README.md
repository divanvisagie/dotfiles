Restart when config has changed

```sh
pkill xbindkeys && xbindkeys
```

Find conflicts
```sh
gsettings list-recursively | grep '<Super>s'
```

