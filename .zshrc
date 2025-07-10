# launch tmux
if [ -z "$TMUX" ]; then
    exec tmux new-session -A -s def
fi
# useful abbreviations
alias s='sudo'
#alias z='cd'
if [ -n "$TERMUX_VERSION" ]; then
  alias su='tsu'
  alias upm='pkg'
  #alias pkg='upm'
elif grep -q 'ID=arch' /etc/os-release 2>/dev/null; then
  alias upm='pacman'
else then
  alias upm='dnf'
fi
alias u='upm'
alias n='nvim'
alias c='clear'
alias v='vim'
alias l='ls'
alias t='touch'
alias k='cat'
alias m='cmatrix'
alias e='exit'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias zshrc='n ~/.zshrc'
alias gitconfig='n ~/.gitconfig'
alias sstoml='n ~/.config/starship.toml'
export proj="$HOME/Document/Project"
# zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
# plugins
zinit ice depth=1
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# basic settings
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
# setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# Autocomplete
zstyle :compinstall filename '~/zshrc'
autoload -Uz compinit
compinit

# vim mode
set -o vi
# launch zoxide
eval "$(zoxide init zsh)"
# launch starship
eval "$(starship init zsh)"
