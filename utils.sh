#!/bin/bash

command_exists() {
	command -v "$1" &> /dev/null
}

is_headless() {
	[ -z "$DISPLAY" ]
}

# Writes an env export to the machine specific prefs sh file
# so that user choices about dotfiles can be persisted.
# Example Usage: write_env "MACHINE_TYPE" "laptop"
write_env() {
  local env_var="export $1=$2"
  if grep -q "$env_var" ~/.dotfiles/bash/prefs.sh; then
	return
  fi
  echo $env_var >> ~/.dotfiles/bash/prefs.sh
}

log_info() {
  if $DEBUG; then
	  return
  fi
  echo -e "\e[32m$1\e[0m"
}
