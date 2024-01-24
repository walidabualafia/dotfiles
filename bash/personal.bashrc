#
# bash prompt
export PS1="\[\033[0;37m\][\[\033[0;33m\]\u\[\033[0;97m\]@\[\033[0;36m\]\h \[\033[0;33m\]\w\[\033[0;37m\]]\[\033[0;92m\]$\[\033[0;97m\] "

# colorize CLI output
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagaced
alias ls='ls -G'
alias ll='ls -lG'

export JAVA_HOME=$(/usr/libexec/java_home)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/walidabualafia/google-cloud-sdk/path.bash.inc' ]; then . '/Users/walidabualafia/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/walidabualafia/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/walidabualafia/google-cloud-sdk/completion.bash.inc'; fi

# The next line updates PATH for git.
export PATH="/usr/local/bin/git:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

