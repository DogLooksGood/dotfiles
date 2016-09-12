#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

alias vim="nvim"
alias p="proxychains4 -q"
alias e="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n $1"

# Autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Virtualenvwrapper
# source /usr/local/bin/virtualenvwrapper.sh

# Fzf
source ~/.fzf/shell/completion.zsh
source ~/.fzf/shell/key-bindings.zsh

# nvm
PATH=~/.nvm/versions/node/v6.5.0/bin:$PATH

# Android
PATH=/Users/DogLooksGood/Library/Android/sdk/tools:$PATH

