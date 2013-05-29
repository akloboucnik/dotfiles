export PATH="/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/share/npm/bin:$PATH"
export HISTCONTROL="ignoreboth"
#export EDITOR='subl -nw'
export EDITOR='mvim -f'
export GIT_EDITOR='mvim -f -c"au VimLeave * !open -a Terminal"'

# npm bash completion
source "`brew --prefix`/etc/bash_completion.d/npm"

# git bash completion
source "`brew --prefix`/etc/bash_completion.d/git-completion.bash"
source "`brew --prefix`/etc/bash_completion.d/git-prompt.sh"
export GIT_PS1_SHOWDIRTYSTATE='1'
export GIT_PS1_SHOWUPSTREAM='1'

# setup git branch in prompt
#GIT_PS1_SHOWDIRTYSTATE=1
# export PS1='\h:\W \[\033[01;32m\]$(git symbolic-ref HEAD 2> /dev/null | cut -d / -f 3 | cut -c1-15)...\[\033[00m\] \u\$ '
export PS1='\h:\W$(__git_ps1 " (\[\033[01;32m\]%s\[\033[00m\])") \u\$ '

# git achievements
export PATH="$PATH:/Users/adam/Prog/git-achievements"
alias git="git-achievements"

# CL Tool to path
export PATH="$PATH:/Users/adam/Work/gdc/gooddata-cli-1.2.65/bin"

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
