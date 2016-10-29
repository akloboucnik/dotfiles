# vim: filetype=sh
for file in ~/.{path,exports,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# git bash completion
source "/usr/local/etc/bash_completion.d/git-completion.bash"
source "/usr/local/etc/bash_completion.d/git-prompt.sh"

# setup git branch in prompt
export PS1='\h:\W$(__git_ps1 " (\[\033[01;32m\]%s\[\033[00m\])") \u\$ '
