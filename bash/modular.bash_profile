# bash prompt colors
GRAY="\[\033[0;37m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;36m\]"
GREEN="\[\033[0;92m\]"
RESET="\[\033[0;97m\]"

# bash prompt
export PS1="${GRAY}[${YELLOW}\u${GRAY}@${BLUE}\h${GRAY}: ${YELLOW}\W${GRAY}]${GREEN}$ ${RESET}"

# colorize CLI output
export CLICOLOR=1
export LSCOLORS=exhxBxDxcxegedabagaced
alias ls='ls -G'
alias ll='ls -lG'

# ## #################### ## #
# ## PROMPT CUSTOMIZATION ## #
# ## #################### ## #
# linux prompt
alias linux="export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'"
# turn oh-my-bash on (cannot be turned off)
alias beautify="source ~/.omb.bashrc; export CLICOLOR=1; export LSCOLORS=exhxBxDxcxegedabagaced; alias ls='ls -G'; alias ll='ls -lG'"
# turn on powerline-shell
alias powerline="source ~/.powerline.bashrc"
# turn on sexy
alias sexy="source ~/.sexy.bashrc"

# simplify python3 -> python
alias python="python3"

export JAVA_HOME=$(/usr/libexec/java_home)

# GOLANG env setup
export GOPATH=$HOME/GoProjects
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Racket env setup
export RACKET=/Applications/Racket
export PATH=$PATH:$RACKET/bin

## The next line updates PATH for the Google Cloud SDK.
#if [ -f '/Users/walidabualafia/google-cloud-sdk/path.bash.inc' ]; then . '/Users/walidabualafia/google-cloud-sdk/path.bash.inc'; fi
#
## The next line enables shell command completion for gcloud.
#if [ -f '/Users/walidabualafia/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/walidabualafia/google-cloud-sdk/completion.bash.inc'; fi

# The next line updates PATH for git.
export PATH="/usr/local/bin/git:$PATH"

# The next line updates PATH with /sbin for homebrew.
export PATH="/usr/local/sbin:$PATH"
# Configuration for brew autocompletion
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

# Ruby initialization
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3

# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"

## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/Users/walid/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#  eval "$__conda_setup"
#else
#  if [ -f "/Users/walid/mambaforge/etc/profile.d/conda.sh" ]; then
#    . "/Users/walid/mambaforge/etc/profile.d/conda.sh"
#  else
#    export PATH="/Users/walid/mambaforge/bin:$PATH"
#  fi
#fi
#unset __conda_setup
#
#if [ -f "/Users/walid/mambaforge/etc/profile.d/mamba.sh" ]; then
#  . "/Users/walid/mambaforge/etc/profile.d/mamba.sh"
#fi
## <<< conda initialize <<<

test -e "${HOME}/.scripts/iterm2/.iterm2_shell_integration.bash" && source "${HOME}/.scripts/iterm2/.iterm2_shell_integration.bash" || true

