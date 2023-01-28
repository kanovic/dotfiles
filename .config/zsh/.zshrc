autoload -U colors && colors		# Load colors
setopt autocd				# Automatically cd into typed directory.
stty stop undef				# Disable ctrl-s to freeze terminal.
setopt interactive_comments

HISTSIZE=10000000
SAVEHIST=10000000

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

alias ll='ls -lhF'
alias la='ls -lahF'
alias vi='nvim'
alias vim='nvim'
alias dotfiles='/usr/bin/git --git-dir=/Users/koen/.dotfiles/ --work-tree=/Users/koen'

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
