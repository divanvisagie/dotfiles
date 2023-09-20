alias cb='git branch --show-current'
alias uuid="uuidgen | tr 'A-F' 'a-f'"

function dm() {
  eval "$(~/.dotfiles/scripts/darkmode.sh)"
}

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
