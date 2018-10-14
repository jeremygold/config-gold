function fish_right_prompt -d "Write out the right prompt"
    set now (date "+%H:%M")
    echo $CMD_DURATION $now
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
alias sysup='sudo apt update ;and sudo apt upgrade ;and sudo apt autoremove'

set hostname (hostname)
/usr/bin/keychain $HOME/.ssh/id_rsa
source $HOME/.keychain/$hostname-fish

