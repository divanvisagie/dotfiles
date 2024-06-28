#!/bin/bash

is_installed() {
  dpkg -l "$1" &> /dev/null
}


