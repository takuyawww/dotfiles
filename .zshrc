# environment
export LANG=ja_JP.UTF-8
export GITHUB_TOKEN=$(gh auth token)

# prompt
function git-prompt {
  local branch_name st branch_status

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
    echo "039m"
  elif [[ $username == "takuyawakazono" ]] then
    echo "039m"
  else
    echo "039m"
  fi
}

setopt prompt_subst

# for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
PROMPT=$'%{\e[039;48;5;`prompt-color`%}%{\e[38;5;255m%}%D %* [%n] %(5~,%-1~/.../%2~,%~) (`git-prompt`)%{\e[0m%} $ '

# alias
alias h="history 100"
alias c="clear"

# git
alias gs="git status"
alias ga="git add ."
alias gb="git branch"
alias gd="git diff"
alias gcm="git commit -v"
alias gc="git checkout"
alias gcd="git checkout develop"
alias gcb="git checkout -b"
alias gp="git push origin HEAD"
alias gstu="git stash -u"
alias gstl="git stash list"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gpua="zsh /Users/takuyawakazono/workspace/git-pull-and-fetch.sh"
alias gpud="git pull origin develop && git fetch"
alias gpum="git pull origin master && git fetch"
alias gmd="git merge develop"
alias gmm="git merge master"
alias gbd="git branch | grep -v 'main\|master\|develop\|*' | xargs -r git branch -D"

# git worktree
alias gwtl="git worktree list"
alias gwta="git worktree add -b"
alias gwtr="git worktree remove"
alias gwtp="git worktree prune"

# difit(https://github.com/yoshiko-pg/difit)
alias dif="npx difit --port 4000"

# utility
alias fmtdate="date '+%Y%m%d%H%M%S'"

# go
alias gm="go mod tidy && go mod vendor"

# homebrew
export PATH="$PATH:/opt/homebrew/bin"

# docker
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"

# claude
export PATH=~/.npm-global/bin:$PATH

alias cl="claude"

# nvim
alias n="nvim"
