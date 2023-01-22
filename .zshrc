# environment
export LANG=ja_JP.UTF-8

# prompt
function git-prompt {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`

  st=`git status 2> /dev/null`

  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    branch_status=""
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    branch_status="*"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    branch_status="!"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    branch_status="+"
  else
    branch_status=""
  fi
  echo "$branch_name${branch_status}"
}

function prompt-color {
  username=$(whoami)

  if [[ $username == "wakazonotakuya" ]] then
    echo "032m"
  else
    echo "078m"
  fi
}

setopt prompt_subst

# for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
PROMPT=$'%{\e[30;48;5;`prompt-color`%}%{\e[38;5;255m%}%D %* [%n] %(5~,%-1~/.../%2~,%~) (`git-prompt`)%{\e[0m%} $ '

# alias
alias -g L="| less"
alias d="cd ~"
alias h="history"
alias c="clear"
alias t="time"
alias n="nvim"
alias e="export"
alias s="source"
alias lg="lazygit"

# git
alias gs="git status"
alias ga="git add ."
alias gb="git branch"
alias gd="git diff"
alias gcm="git commit -v"
alias gc="git checkout"
alias gp="git push origin HEAD"
alias gpu="git pull oriin"
alias gstu="git stash -u"
alias gstl="git stash list"
alias gsta="git stash apply"
alias gstd="git stash drop"

# go
alias gofmtall="gofmt -l -s -w ."

# docker
alias dc="docker"
alias d-c="docker container"
alias d-i="docker image"

# rbenv
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(~/.rbenv/bin/rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# yarn
export PATH="$PATH:/opt/yarn-[version]/bin"
