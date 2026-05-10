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
  echo "039m"
  # echo "140m"
  # for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
}

setopt prompt_subst
PROMPT=$'%{\e[039;48;5;`prompt-color`%}%{\e[38;5;255m%}%D %* [%n] %(5~,%-1~/.../%2~,%~) (`git-prompt`)%{\e[0m%} $ '

# utility
alias h="history 100"
alias c="clear"
alias dt="date '+%Y%m%d%H%M%S'"

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

# golang
alias gm="go mod tidy && go mod vendor"

# Kubenetes
alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias ka="kubectl apply -f"
alias kl="kubectl logs"

# Homebrew
export PATH="$PATH:/opt/homebrew/bin"

# Docker
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"

# Claude Code
export PATH="$HOME/.local/bin:$PATH"
alias cl="claude"

# Neovim
alias n="nvim"

# Raspberry Pi
alias pi="ssh takuyawww@raspberrypi5.local"