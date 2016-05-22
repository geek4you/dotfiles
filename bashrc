
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

source ~/.fzf.bash
source ~/.aws/dev_credentials

##================ OOYALA ==================================
source ~/.aws/dev_credentials

export OOYALA_REPO_ROOT=$HOME/repos
export OOYALA_CODE_ROOT=$OOYALA_REPO_ROOT/ooyala

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home"

dsh_groups() { reply=($(ls $HOME/.dsh/group/)) }
compctl -K dsh_groups -x 's[-g]' -- pdsh

export HADOOP_HOME=/Users/pchanumolu/repos/vendor/hadoop_distros/current-cdh5
export HADOOP_CONF_DIR=/Users/pchanumolu/repos/vendor/hadoop_distros/current-cdh5/conf-cdh5-next-staging
export PATH=$HADOOP_HOME/bin:$PATH
