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

# Change this value to set how frequently ZSH updates¬
export UPDATE_ZSH_DAYS=30

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Customize to your needs...
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

export TERM=xterm-256color
if [[ $platform == 'linux' ]]; then
  if [ -x dircolors ]; then
    eval `dircolors ~/.dotfiles/dircolors-solarized/dircolors.ansi-dark`
  fi
elif [[ $platform == 'osx' ]]; then
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#[[ $- != *i* ]] && return
#[[ -z "$TMUX" ]] && exec tmux

#local
if [ -e "$HOME/.zshrc.local" ] ; then
    source ~/.zshrc.local
fi

# Fzf source
source ~/.fzf.zsh

# press Ctrl-Z to come out on vim and press again Ctrl-Z go into vim again
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
      BUFFER="fg"
      zle accept-line
    else
        zle push-input
        zle clear-screen
      fi
  }
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
