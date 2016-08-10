# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="clean"

# alias slic3r="/home/jeremy/3dPrinting/Slic3r/bin/slic3r"
# alias netfabb="/home/jeremy/3dPrinting/netfabb-basic/netfabb"
alias tmux="tmux -2 a"
alias gpoh="git push origin HEAD"
alias gpfoh="git push --force origin HEAD"
alias gfl="git fetch && git l"

plugins=(git)
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# Linux version
# export PATH=$HOME/MyDocs/bin:$PATH
# Mac version
export PATH=$PATH:$HOME/MyDocs/bin

RPROMPT="%t"

# Vim setup - ref http://www.drbunsen.org/the-text-triumvirate/
# Use vim keybindings
export EDITOR="vim"
bindkey -v 

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward  

export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Initialize ROS
source /opt/ros/kinetic/setup.zsh

/usr/bin/keychain $HOME/.ssh/id_rsa
source $HOME/.keychain/`hostname`-sh
