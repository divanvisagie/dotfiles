alias cb='git branch --show-current'
alias uuid="uuidgen | tr 'A-F' 'a-f'"
alias sf="source ~/.zshrc"
alias ls="exa"
alias cleaner=sed -n '/```/,/```/p' | sed '/```/d'
alias flushdns='sudo killall -HUP mDNSResponder'
alias mac="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//'"

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
