#!/bin/bash

command_exists() {
	command -v "$1" &> /dev/null
}

is_installed() {
  dpkg -l "$1" &> /dev/null
}
