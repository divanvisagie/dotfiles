ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Set the default editor
export EDITOR='nvim'

# zinit ice depth=1; zinit light romkatv/powerlevel10k
# zinit for starship rs
zinit ice depth=1; zinit light starship/starship
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::yarn
# zinit snippet OMZP::rust

# if on ubuntu
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    zinit snippet OMZP::ubuntu
    alias wezterm='flatpak run org.wezfurlong.wezterm'
    alias marktext='flatpak run com.github.marktext.marktext'
fi
# if on mac
if [[ "$OSTYPE" == "darwin"* ]]; then
    zinit snippet OMZP::brew
fi

autoload -U compinit && compinit

# ZSH_THEME="powerlevel10k/powerlevel10k"
export TERM=xterm-256color
export EDITOR='nvim'

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt sharehistory

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Use LS_COLORS for completion colors

# Aliases
alias cb='git branch --show-current'
alias uuid="uuidgen | tr 'A-F' 'a-f'"
alias sf="source ~/.zshrc"
alias ls="eza --group-directories-first"
alias flushdns='sudo killall -HUP mDNSResponder'
alias gtop='git log -1 --format="%H" | cat | xargs echo -n | pbcopy'
alias ns='nix-search'
alias nu='~/.dotfiles/nix/install.sh' # Update nix environment
alias ne='$EDITOR ~/.dotfiles/nix/default.nix' # Edit nix environment
alias ni='nix-env -i'
alias ed='$EDITOR'
alias nv='nvim'
alias dfu='~/.dotfiles/install.sh' # Update dotfiles
alias rsync='rsync --partial --info=progress2'
alias fd='fd --color never'

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export GDK_BACKEND=wayland
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
fi

# Custom functions
function strp() {
 awk '
    /```/ { p=!p; next }
    p     { print }
  '
}

# A shutdown system 
function down() {
   # Get the name of the primary network interface
   local interface=$(ip route | grep '^default' | awk '{print $5}')
   
   # Check if an interface is found
   if [ -z "$interface" ]; then
       echo "No network interface found. Ensure you are connected to a network."
       return 1
   fi

   # Apply the Wake-on-LAN setting
   sudo ethtool -s "$interface" wol g
   if [[ $? -ne 0 ]]; then
       echo "Failed to set Wake-on-LAN for $interface"
       return 1
   fi

   # Shutdown the system
   echo "Shutting down..."
   sudo shutdown -h now
}

function kb() {
    for job in $(jobs -p); do kill -9 $job; done
}

function today() {
    local filename=$(date "+%Y-%m-%d").md

    if [[ -f "$filename" ]]; then
        echo "Opening existing file: $filename"
        nvim "$filename"
    else
        touch "$filename"
        echo "New markdown file created: $filename"
        nvim "$filename"
    fi
}

function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function httpserver () {
    local port="${1:-8000}"
    python3 -m http.server "$port"
}

# ##################################################
# Loaders that either execute on shell load or when 
# a specific command is run
# ##################################################

# on directory change
function chpwd() {
    local title=$(basename "$PWD")
    echo -ne "\x1b]0;$title\x1b\\"
}
local title=$(basename "$PWD")
echo -ne "\x1b]0;$title\x1b\\"

# Shell integrations
eval "$(direnv hook zsh)"

# Enable vi mode, we do this before 
# starship so that we dont interfere with it 
# afterward
bindkey -v

# Automatically CD when providing a file path
setopt AUTO_CD

# Initialize Starship prompt
eval "$(starship init zsh)"

