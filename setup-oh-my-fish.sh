#!/bin/bash

# Install latest fish using ppa repo
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install -y fish

# Install powerline enhanced fonts
sudo apt-get install -y fonts-powerline

# Install oh-my-fish
curl -L https://get.oh-my.fish | fish

# Install bobthefish theme
omf install bobthefish
omf theme bobthefish


