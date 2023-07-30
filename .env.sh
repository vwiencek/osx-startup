export LANG=en_US.UTF-8
export NODE_ENV=standalone

export USER_HOME=/Users/vwiencek
export DEV_HOME=$USER_HOME/dev
export FLUTTER_HOME=$DEV_HOME/flutter

export PATH=$PATH:/usr/local/opt/curl/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$FLUTTER_HOME/bin

export SPARK_HOME=/Users/vwiencek/dev/spark

export ANDROID_HOME=/Users/$(whoami)/Library/Android/sdk
export GRAALVM_HOME=/Users/vwiencek/.sdkman/candidates/java/20.0.2-graalce
export GRAALVM_DIR=$GRAALVM_HOME
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$GRAALVM_DIR/bin

# Alias Docker
alias dc='docker-compose'
alias j20='sdk use java 20.0.2-tem'
alias j17='sdk use java 17.0.8-tem'
alias gvm20='sdk use java 20.0.2-graalce'
alias gvm17='sdk use java 17.0.8-graalce'
alias ls='ls -ahlG'
alias node18='nvm use 18.17.0'

alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias docker_ds='docker run -it -v /Users/vwiencek/dev:/home/jovyan/work --rm -p 8888:8888 jupyter/all-spark-notebook'
alias docker_clean='docker rm $(docker ps --filter=status=exited --filter=status=created -q) && docker rmi $(docker images -a --filter=dangling=true -q)'

# Alias system
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation

# alias edit='subl'                         # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion