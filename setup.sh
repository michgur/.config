#!/bin/bash

defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
echo 'export ZDOTDIR="$HOME/.config/zsh"' > ~/.zshenv
tmux -f ~/.config/tmux/tmux.conf
