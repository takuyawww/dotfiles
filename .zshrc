# LANG
export LANG=ja_JP.UTF-8

# https://qiita.com/koki0527/items/ca734df6fa86a8dbd241
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    branch_status=""
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    branch_status="!"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    branch_status="*"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    branch_status="+"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    echo "!!"
    return
  else
    branch_status=""
  fi
  echo "$branch_name${branch_status}"
}

setopt prompt_subst

# PROMPT
PROMPT='%K{blue}%* [%n] %(5~,%-1~/.../%2~,%~) (`rprompt-git-current-branch`)%k '

# ALIAS
alias h="history 100"
# Git
alias gs="git status"
alias ga="git add ."
alias gd="git diff"
alias gcm="git commit -v"
alias gc="git checkout"
alias gp="git push origin HEAD"
alias gpu="git pull oriin"

# color
# for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
