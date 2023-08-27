You can set up the darkmode script by adding the following to .zshrc

```sh
function dm() {
  eval "$(~/.dotfiles/scripts/darkmode.sh)"
}
```


Notes organisation:
```sh
function today() {
    local filename=$(date "+%Y-%j").md

    if [[ -f "$filename" ]]; then
        echo "Opening existing file: $filename"
        nvim "$filename"
    else
        touch "$filename"
        echo "New markdown file created: $filename"
        nvim "$filename"
    fi
}
```
