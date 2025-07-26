# Sets the number of commands to remember in the command history
HISTSIZE=5000

# Sets the number of commands to be saved in the history file
HISTFILESIZE=5000

# Specifies the file where the command history is saved
HISTFILE=~/.bash_history

# Ignores duplicate commands
HISTCONTROL=ignoredups

# Ignores commands that start with a space
HISTCONTROL=ignoreboth

# Appends the history to the history file rather than overwriting it
shopt -s histappend

# Ensures that duplicate commands are not stored in the history
HISTCONTROL=erasedups
