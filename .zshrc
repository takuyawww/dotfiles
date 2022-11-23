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
alias w="cd home/workspace"
alias h="history 100"

# Git
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

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(~/.rbenv/bin/rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
