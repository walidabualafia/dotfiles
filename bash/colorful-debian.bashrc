#
# colorful-debian.bashrc
#
# description: simple debian style [user@host: cwd]$
#              with cool colors
#

# bash prompt
export PS1="\[\033[0;37m\][\[\033[0;33m\]\u\[\033[0;97m\]@\[\033[0;36m\]\h \[\033[0;33m\]\w\[\033[0;37m\]]\[\033[0;92m\]$\[\033[0;97m\] "

#
# MAC ONLY
#
# colorize CLI output
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagaced
alias ls='ls -G'
alias ll='ls -lG'
