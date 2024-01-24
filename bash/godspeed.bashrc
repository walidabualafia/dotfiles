# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# colors 
export GRAY="\[\033[1;37m\]"
export YELLOW="\[\033[1;33m\]"
export CYAN="\[\033[1;36m\]"
export GREEN="\[\033[0;92m\]"
export RESET="\[\033[0;97m\]"

export PS1="$YELLOW\h $GRAY>> $CYAN\w ${RESET}# "

alias tmux="tmux -u"
alias vim="nvim"
alias vi="/usr/bin/vim"
alias hn="echo $HOSTNAME"

# spack
PATH=$HOME/.local/apps/spack/bin:$PATH
LD_LIBRARY_PATH=$HOME/.local/apps/spack/lib:$LD_LIBRARY_PATH
MANPATH=$HOME/.local/apps/share/man:$MANPATH

# neovim
PATH=$HOME/.local/apps/nvim-linux64/bin:$PATH
LD_LIBRARY_PATH=$HOME/.local/apps/nvim-linux64/lib:$LD_LIBRARY_PATH

# bat
PATH=$HOME/.conda/envs/bat/bin:$PATH
LD_LIBRARY_PATH=$HOME/.conda/envs/bat/lib:$LD_LIBRARY_PATH
INFOPATH=$HOME/.conda/envs/share/info:$INFOPATH

# mamba
export MAMBA_ENVS=$HOME/.conda/envs

export LMOD_COLORIZE=YES

# export all
export PATH
export LD_LIBRARY_PATH
export MANPATH
export INFOPATH
