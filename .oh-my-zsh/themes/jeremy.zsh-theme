# af-magic.zsh-theme
#
# Author: Andy Fleming
# URL: http://andyfleming.com/
#
# NOTE: If extra conda env info is being shown on the dashed line,
# Ensure you have .condarc with changeps1: False

# Disable automatic virtualenv prompt display
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Command execution time tracking
function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    unset timer
  fi
}

function exec_time_info() {
  if [[ -n $timer_show ]] && [[ $timer_show -gt 2 ]]; then
    local time_str=""
    if [[ $timer_show -gt 60 ]]; then
      local minutes=$((timer_show / 60))
      local seconds=$((timer_show % 60))
      time_str="${minutes}m${seconds}s"
    else
      time_str="${timer_show}s"
    fi
    echo "%{$fg[yellow]%}⏱ ${time_str}%{$reset_color%} "
  fi
}

# dashed separator size
function afmagic_dashes {
  # Since we handle virtualenv display in RPS1, just return full width
  echo $COLUMNS
}

function conda_info {
    if [[ -n "$CONDA_DEFAULT_ENV" && "$CONDA_DEFAULT_ENV" != "base" ]]; then
        echo "%{$fg[green]%}‹${CONDA_DEFAULT_ENV}›%{$reset_color%}"
    fi
}

function venv_info {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local python_version=$(python --version 2>&1 | cut -d' ' -f2 | cut -d'.' -f1,2)
        echo "%{$fg[blue]%}(${VIRTUAL_ENV##*/} py${python_version})%{$reset_color%} "
    fi
}

local conda='$(conda_info)'
local venv='$(venv_info)'

# primary prompt: dashed separator, directory and vcs info
PS1="${FG[237]}\${(l.\$(afmagic_dashes)..-.)}%{$reset_color%}
${FG[032]}%~\$(git_prompt_info)\$(hg_prompt_info) ${FG[105]}%(!.#.»)%{$reset_color%} "
PS2="%{$fg[red]%}\ %{$reset_color%}"

# right prompt: return code, execution time, virtualenv, conda env, and timestamp
RPS1="%(?..%{$fg[red]%}%? ↵ %{$reset_color%})"
RPS1+="\$(exec_time_info)"
RPS1+="${venv}${conda}"
RPS1+="%{$fg[yellow]%}[%*]%{$reset_color%}"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[075]}(${FG[078]}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[214]}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${FG[075]})%{$reset_color%}"

# hg settings
ZSH_THEME_HG_PROMPT_PREFIX=" ${FG[075]}(${FG[078]}"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_DIRTY="${FG[214]}*%{$reset_color%}"
ZSH_THEME_HG_PROMPT_SUFFIX="${FG[075]})%{$reset_color%}"

# virtualenv settings - disable automatic display since we handle it in RPS1
ZSH_THEME_VIRTUALENV_PREFIX=""
ZSH_THEME_VIRTUALENV_SUFFIX=""
