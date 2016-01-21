# Clean, simple, compatible and meaningful.
# Tested on Linux under ANSI colors.
# It is recommended to use with a dark background or solarized
# Colors: red, green, yellow, cyan and white.
# 
# Template name: valencia
# Author: Fidel Añó (haider1987@gmail.com)
# Date: January 2016

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Variables git info
COLOR_GIT_DIRTY="%{$fg[red]%}"
COLOR_GIT_CLEAN="%{$fg[green]%}"
RESET_COLORS="%{$reset_color%}"

local git_info='$(get_git_info)'
get_git_info() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')
  local ref

  # Check if working tree is dirty
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi

  if [ -d .git ]; then
    if [[ -n $STATUS ]]; then
      echo -n "$COLOR_GIT_DIRTY"
      echo -n " ($(git_current_branch))"
    else
      echo -n "$COLOR_GIT_CLEAN"
      echo -n " ($(git_current_branch))"
    fi
    echo -n "$RESET_COLORS"
  else
  fi;
}

# Prompt format: TIME DIRECTORY GIT_BRANCH $ 

PROMPT="%{$fg[cyan]%}%* \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${git_info} \
%{$terminfo[bold]$fg[cyan]%}$ %{$reset_color%}"

