# vim: filetype=sh

# locale - setup first - do not move to `export`
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

platform=`uname`

# load children
for file in ~/.{path,exports,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# git bash completion
if [[ $platform == 'Darwin' ]]; then
    source "/usr/local/etc/bash_completion.d/git-completion.bash"
    source "/usr/local/etc/bash_completion.d/git-prompt.sh"
elif [[ $platform == 'Linux' ]]; then
    source "/usr/share/bash-completion/completions/git"
    source "/usr/share/git-core/contrib/completion/git-prompt.sh"
fi

# use z
source "`brew --prefix`/etc/profile.d/z.sh"

# setup virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# setup git branch in prompt
export PS1='\h:\W$(__git_ps1 " (\[\033[01;32m\]%s\[\033[00m\])") \u\$ '
