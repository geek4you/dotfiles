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

##================ OOYALA ==================================
source ~/.aws/dev_credentials

export OOYALA_REPO_ROOT=$HOME/repos
export OOYALA_CODE_ROOT=$OOYALA_REPO_ROOT/ooyala

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home"

dsh_groups() { reply=($(ls $HOME/.dsh/group/)) }
compctl -K dsh_groups -x 's[-g]' -- pdsh

export HADOOP_HOME=/Users/pchanumolu/repos/vendor/hadoop_distros/current-cdh5
export PATH=$HADOOP_HOME/bin:$PATH

export HIVE_HOME=/usr/local/apache-hive-1.2.1-bin
export PATH=$HIVE_HOME/bin:$PATH

export CHEF_REPO=/Users/pchanumolu/repos/chef/chef-repo

function prod
{
unset HADOOP_CONF_DIR
unset HIVE_CONF_DIR
}

function staging
{
export HADOOP_CONF_DIR=/Users/pchanumolu/repos/vendor/hadoop_distros/current-cdh5/conf-cdh5-staging
export HIVE_CONF_DIR=$OOYALA_REPO_ROOT/vendor/hive_distros/apache-hive-0.14.0-bin/conf-staging
}

function next-staging
{
export HADOOP_CONF_DIR=/Users/pchanumolu/repos/vendor/hadoop_distros/current-cdh5/conf-cdh5-next-staging
export HIVE_CONF_DIR=$OOYALA_REPO_ROOT/vendor/hive_distros/apache-hive-0.14.0-bin/conf-next-staging
}

#=================  Z ======================================
. ~/.dotfiles/z/z.sh

#=============== HADOOP ===================================
export ZOOKEEPER_HOME=/Users/pchanumolu/my-setups/zookeeper-3.3.6/
export PATH=$ZOOKEEPER_HOME/bin:$PATH
export STORM_HOME=/usr/local/storm/apache-storm-0.9.2-incubating
export PATH=$STORM_HOME/bin:$PATH

#================= TEZ ===========================
#export TEZ_VERSION=0.5.4
#export TEZ_HOME=/usr/local/tez
#export TEZ_INSTALL_DIR=/usr/local/tez/tez-dist/target/tez-0.5.4
#export TEZ_DIST=/usr/local/tez/tez-dist/target/tez-0.5.4
#export TEZ_CONF_DIR=$TEZ_DIST/conf
#export TEZ_JARS=$(echo "$TEZ_DIST"/*.jar | tr ' ' ':'):$(echo "$TEZ_DIST"/lib/*.jar | tr ' ' ':')
#if [ -z "$HIVE_AUX_JARS_PATH" ]; then
#    export HIVE_AUX_JARS_PATH="$TEZ_JARS"
#else
#    export HIVE_AUX_JARS_PATH="$HIVE_AUX_JARS_PATH:$TEZ_JARS"
#fi
#export HADOOP_CLASSPATH="${TEZ_CONF_DIR}:${TEZ_JARS}/*:${TEZ_JARS}/lib/*"
#=============== rbenv ===========
export PATH=$HOME/.rbenv/shims:$PATH

#=======FLASH============
export FLEX_HOME=$HOME/flex-4.5.1 && export PATH="$FLEX_HOME/bin:$PATH"

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



#====== set chef ruby version globally =======
eval "$(chef shell-init zsh)"
