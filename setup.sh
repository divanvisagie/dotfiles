#!/usr/bin/env bash

cd ~ #always run from the home directory
pwd;

if [ "$1" == "--all" -o "$1" == "-a" ]; then
    echo "Installing all"
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
else
    installers="$(find ./dotfiles -type f -name install.sh)"
    for i in $installers
    do 
        read -p "Do you want to update $i? y/n "
        echo '';
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            $(sh $i)
        fi;
    done;
fi;
