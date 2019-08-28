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

export TERM='xterm-256color'

set fish_command_timer_enabled 1
set -gx PATH $PATH ~/android-studio/bin


set hostname (hostname)
/usr/bin/keychain $HOME/.ssh/id_rsa
source $HOME/.keychain/$hostname-fish

set PATH $PATH ~/Android/Sdk/platform-tools

# Fish setup for n (node version management)
set -x N_PREFIX "$HOME/n"    # equivalent of export N_PREFIX="$HOME/n";

if not contains -- $N_PREFIX/bin $PATH
  set PATH $PATH $N_PREFIX/bin
end
