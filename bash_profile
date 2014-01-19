PATH="/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/share/npm/bin:$PATH"

export HISTCONTROL="ignoreboth"
export EDITOR="vim"

# npm bash completion
source "`brew --prefix`/etc/bash_completion.d/npm"

# git bash completion
source "`brew --prefix`/etc/bash_completion.d/git-completion.bash"
source "`brew --prefix`/etc/bash_completion.d/git-prompt.sh"
export GIT_PS1_SHOWDIRTYSTATE='1'
export GIT_PS1_SHOWUPSTREAM='1'

# setup git branch in prompt
export PS1='\h:\W$(__git_ps1 " (\[\033[01;32m\]%s\[\033[00m\])") \u\$ '

# git achievements
PATH="$PATH:/Users/adam/Play/git-achievements"
alias git="git-achievements"

# CL Tool to path
PATH="$PATH:/Users/adam/Work/gdc/gooddata-cli-1.2.65/bin"

# aliases
alias ll="ls -l"
alias e='subl .'
alias en='subl -n .'
alias phps='php -S 127.0.0.1:8082'
alias be='bundle exec'
alias g='git'
alias key2clip='cat ~/.ssh/id_rsa.pub | pbcopy'
alias open_payroll='pdfcrack -m 4 -n 4 -charset="1234567890"'

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# cd aliases
alias cdw='cd ~/Work'
alias cdp='cd ~/Prog'
alias cdgdc='cd ~/Work/gdc/gdc-client'

export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)

