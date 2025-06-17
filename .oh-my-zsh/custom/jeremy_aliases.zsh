alias avdev='aws-vault exec sso-ikegps-ai-dev_admin --'
alias avprod='aws-vault exec sso-ikegps-ai-prod_admin --'

alias gfl='git fetch --all && git l'
alias gpoh='git push origin HEAD'
alias gpfoh='git push --force origin HEAD'
alias tmux='tmux -2 a'

alias dcup='docker compose up'
alias dcupb='docker compose up --build'
alias dcd='docker compose down'
alias dcdup='docker compose down && docker compose up'

alias bastiprod='aws-vault exec sso-ikegps-koru-prod-developer -- basti connect --rds-cluster koru-postgis --local-port 5435'
alias bastiprod-ro='aws-vault exec sso-ikegps-koru-prod-developer -- basti connect --rds-instance koru-postgis-instance-2 --local-port 5435'
alias bastidev='aws-vault exec sso-ikegps-koru-dev-developer -- basti connect --rds-cluster koru-postgis --local-port 5433'

