# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="clean"

# alias slic3r="/home/jeremy/3dPrinting/Slic3r/bin/slic3r"
# alias netfabb="/home/jeremy/3dPrinting/netfabb-basic/netfabb"
alias tmux="tmux -2 a"
alias gpoh="git push origin HEAD"
alias gpfoh="git push --force origin HEAD"
alias gfl="git fetch && git l"
alias c="clear"
alias logout="killall StartDwm"

plugins=(git)
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# Linux version
# export PATH=$HOME/MyDocs/bin:$PATH
# Mac version
export PATH=$PATH:$HOME/MyDocs/bin:$HOME/Library/Python/2.7/bin

# Set up vcs_info Ref http://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
autoload -Uz vcs_info

# Style configuration for vcs_info. Ref https://github.com/jleclanche/dotfiles/blob/master/.zshrc
zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:(git*):*" get-revision true
zstyle ":vcs_info:(git*):*" check-for-changes true

local _branch="%{$fg[green]%}%b%{$reset_color%}%c%u%m"
local _repo="%{$fg[green]%}%r %{$fg[yellow]%}%{$reset_color%}"
local _revision="%{$fg[yellow]%}%.7i%{$reset_color%}"
local _action="%{$fg[red]%}%a%{$reset_color%}"
zstyle ":vcs_info:*" stagedstr "%{$fg[yellow]%}✓%{$reset_color%}"
zstyle ":vcs_info:*" unstagedstr "%{$fg[red]%}✗%{$reset_color%}"
zstyle ":vcs_info:git*" formats "($_branch)"
zstyle ":vcs_info:git*" actionformats "($_branch:$_action)"
zstyle ':vcs_info:git*+set-message:*' hooks git-stash

precmd() {
    vcs_info
}

# Configure prompts
PROMPT='%{$fg[grey]%}%B%n@%m%b%{$reset_color%}:%{$fg[blue]%}%B%c/%b%{$reset_color%} ${vcs_info_msg_0_} %(!.#.$) '
RPROMPT='%t'

# Vim setup - ref http://www.drbunsen.org/the-text-triumvirate/
# Use vim keybindings
export EDITOR="vim"
bindkey -v 

# Backup function. Copied from http://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
bk() {
	cp -a "$1" "${1}_$(date --iso-8601=seconds)"
}

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward  

export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools

export local_ip=`ip route get 1 | awk '{print $NF;exit}'`

# Initialize ROS
# source /opt/ros/kinetic/setup.zsh
# export ROS_IP=$local_ip
# export ROS_MASTER_URI=http://$local_ip:11311

/usr/bin/keychain $HOME/.ssh/id_rsa
source $HOME/.keychain/`hostname`-sh

