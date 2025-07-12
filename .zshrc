# launch tmux
if [ -z "$TMUX" ]; then
    exec tmux new-session -A -s 0
fi
clear() {
  command clear
  if [ -n "$TMUX" ]; then
    tmux clear-history
  fi
}
# useful abbreviations
alias q='exit'
alias s='sudo'
alias p='python'
if [ -n "$TERMUX_VERSION" ]; then
  alias su='tsu'
  alias upm='pkg'
  #alias pkg='upm'
elif grep -q 'ID=arch' /etc/os-release 2>/dev/null; then
  alias upm='pacman'
else
  alias upm='dnf'
fi
alias u='upm'
alias n='nvim'
alias c='clear'
alias v='vim'
alias ls='ls --color'
alias l='ls'
alias t='touch'
alias k='cat'
alias m='cmatrix'
alias e='exit'
alias ll='ls -l'
alias la='ls -A' #I don't need .. .
alias lla='ls -lA'
alias lfc='ls -F | cat -n'
alias lfac='ls -Fa | cat -n'
alias zshrc='n ~/.zshrc'
alias gitconfig='n ~/.gitconfig'
alias sstoml='n ~/.config/starship.toml'
alias fman="bash -c 'compgen -c' | fzf | xargs man"
#alias d="mv -f $HOME/trash"
cheh(){curl "https://cheat.sh/$1"}
export proj="$HOME/Document/Project"
export PATH=$HOME/.cargo/bin:$PATH
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
# add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
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
# autocomplete
zstyle :compinstall filename '~/zshrc'
autoload -Uz compinit && compinit
# run bash build-in commands
autoload -Uz bashcompinit && bashcompinit
# completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# keybinding
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# vim mode
set -o emacs
# launch zoxide
eval "$(zoxide init zsh)"
# launch fzf
#eval "$(fzf --zsh)"
# launch starship
eval "$(starship init zsh)"
