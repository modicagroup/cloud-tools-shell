# turn on bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# enable bash tab completion for terraform
complete -C /usr/local/bin/terraform terraform

# force a color prompt
PS1='\u@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;33m\](${OS_REGION_NAME:-$AWS_DEFAULT_REGION})\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# source accessKeys.sh if it exists
if [ -f /workdir/accessKeys.sh ]; then
    . /workdir/accessKeys.sh
fi

# also include any personal customisations
if [ -f /workdir/.bash_aliases_personal ]; then
    . /workdir/.bash_aliases_personal
fi
