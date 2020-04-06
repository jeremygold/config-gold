# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
# source $OMF_PATH/init.fish
function fish_right_prompt -d "Write out the right prompt"
    set now (date "+%H:%M")
    echo $CMD_DURATION_STR $now
end

function fish_greeting
end

alias tmux='tmux -2 a'
alias gst='git status'
alias gdv='git difftool'
alias gf='git fetch'
alias gfc='git fetch ;and git checkout'
alias gfl='git fetch ;and git l'
alias gpoh='git push origin HEAD'
alias gpfoh='git push --force origin HEAD'
alias gco='git checkout'
alias gr='git remote'
alias ga='git add'
alias gc='git commit'
alias gl='git pull'
alias ll='ls -lh'
alias la='ls -lha'
alias c='clear'
alias logout='killall StartDwm'
alias sysup='sudo apt update ;and sudo apt -y upgrade ;and sudo apt autoremove'
alias dcup='docker-compose up'
alias dcdn='docker-compose down'
alias cdc='cd ;and clear'
alias cdg='cd ~/git; and clear'
alias g='cd ~/git ;and clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias venv='source venv/bin/activate.fish'
alias pipreq='pip3 install -r requirements.txt'


export TERM='xterm-256color'

set fish_command_timer_enabled 1
set -gx PATH $PATH ~/android-studio/bin

# /usr/bin/keychain $HOME/.ssh/id_rsa
# source $HOME/.keychain/$hostname-fish

set PATH $PATH ~/Android/Sdk/platform-tools

# Fish setup for n (node version management)
# set -x N_PREFIX "$HOME/n"    # equivalent of export N_PREFIX="$HOME/n";

# if not contains -- $N_PREFIX/bin $PATH
  # set PATH $PATH $N_PREFIX/bin
# end
