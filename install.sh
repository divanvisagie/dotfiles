#!/bin/bash
source ~/.dotfiles/utils.sh
set -e

# Alert user if they are running in sh, since the script only 
# is compatible with bash/zsh arrays

if [ -z "$BASH_VERSION" ] && [ -z "$ZSH_VERSION" ]; then
	echo "Please run this script in bash or zsh, you can do this by simply running ./install.sh"
	exit 1
fi

# generated with toilet -f future "dotfiles"
cat << 'EOF'

╺┳┓┏━┓╺┳╸┏━╸╻╻  ┏━╸┏━┓
 ┃┃┃ ┃ ┃ ┣╸ ┃┃  ┣╸ ┗━┓
╺┻┛┗━┛ ╹ ╹  ╹┗━╸┗━╸┗━┛

-----------------------------------------
Manager for Divan's development system
-----------------------------------------

EOF

# Perform OS specific installs
OS=$(uname)
if [[ "$OS" == "Linux" ]]; then
	echo "Linux detected..."
	echo "No Extra Installation."
else
	echo "macOS detected..."
	~/.dotfiles/brew/install.sh
fi
echo "Installing common dependencies..."

# Starship prompt
if ! command_exists starship; then
	curl -sS https://starship.rs/install.sh | sh
fi

# Install rust if not present 
if ! command_exists rustc; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Define the list of rust tools to install
tools=(
	"cgip"
	"cargo-watch"
)

# Iterate over the tools and install them if they are not already available
for tool in "${tools[@]}"; do
	if ! command -v ${tool%% *} &> /dev/null; then
		echo "${tool%% *} could not be found, installing..."
		cargo install $tool
	else
		log_info "${tool%% *} is already installed."
	fi
done

mkdir -p ~/Projects/com.github

# Install programs with configs
~/.dotfiles/git/install.sh
~/.dotfiles/nvim/install.sh
~/.dotfiles/tmux/install.sh
~/.dotfiles/vim/install.sh

# Install custom tools
echo "Installing dark mode switcher..."
cargo install --path ~/.dotfiles/scripts/dm

# if prefs exists, source it
if [ -f ~/.dotfiles/bash/prefs.sh ]; then
	source ~/.dotfiles/bash/prefs.sh
fi

cat << 'EOF'

Installation complete!

EOF
