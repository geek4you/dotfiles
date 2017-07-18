#npm install --global wifi-password
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

# tmux alias
#tl: list sessions

alias tl='tmux ls'

#tn <name>: create a session named <name>

alias tn='tmux -2 new -s'

#ta <name>: attach to a session named <name>

alias ta='tmux -2 attach -t'

#=================  Z ======================================
. ~/.dotfiles/z/z.sh

#========HADOOP ALIAS=============
yarnlogs() {
    hadoop fs -ls /data/hadoop/hadoop-yarn/apps/pchanumolu/logs/$1
}
alias yl='yarnlogs'
alias hcat='hadoop fs -cat'
alias hc='hcat'
alias hls='hadoop fs -ls'
alias hl='hls'
alias hget='hadoop fs -get'
alias hput='hadoop fs -put'
alias hrmr='hadoop fs -rm -R'
alias yarnkill='yarn application -kill'
alias yk='yarnkill'

export PATH=/Users/pradeepchanumolu/repos/quark-docker/user-scripts:$PATH

#================= APPLE =======================
alias neutroncli="$HOME/Library/Python/2.7/bin/neutroncli"
alias socks_proxy="ssh -fN -D 7777 st14a12ls-launchpad0001.st.ls.apple.com"

export HADOOP_HOME=/usr/local/hadoop

function staging
{
export HADOOP_CONF_DIR=${HADOOP_HOME}/staging-conf
}

export PATH=$PATH:${HADOOP_HOME}/sbin/:${HADOOP_HOME}/bin:
source ~/.yubiagent

export JAVA_HOME=$(/usr/libexec/java_home)

eval "$(scalaenv init -)"
