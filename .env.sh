# Backup this file to Dropbox in the background — CloudStorage I/O can
# block for seconds when Dropbox is syncing, so never wait on it.
(cp -f ~/.env.sh "$HOME/Library/CloudStorage/Dropbox/dev/" >/dev/null 2>&1 &)

export LANG=en_US.UTF-8
export NODE_ENV=standalone

export USER_HOME=/Users/vwiencek
export DEV_HOME=$USER_HOME/dev

export PATH=$PATH:/usr/local/opt/curl/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/opt/cross/bin

export SPARK_HOME=/Users/vwiencek/dev/spark
export ANDROID_HOME=/Users/$(whoami)/Library/Android/sdk
export GRAALVM_HOME=/Users/vwiencek/.sdkman/candidates/java/25.0.1-graalce
export GRAALVM_DIR=$GRAALVM_HOME
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$GRAALVM_DIR/bin:/usr/local/bin

# Alias Docker
alias dc='docker-compose'

alias j23='sdk install java 23.0.2-tem && sdk use java 23.0.2-tem'
alias j21='sdk install java 21.0.9-tem && sdk use java 21.0.9-tem'
alias j17='sdk install java 17.0.17-tem && sdk use java 17.0.17-tem'
alias gvm21='sdk install java 21.0.2-graalce && sdk use java 21.0.2-graalce'
alias gvm23='sdk install java 23.0.2-graalce && sdk use java 23.0.2-graalce'
alias gvm24='sdk install java 24.0.2-graalce && sdk use java 24.0.2-graalce'
alias gvm25='sdk install java 25.0.1-graalce && sdk use java 25.0.1-graalce'

alias ls='ls -ahlG'
alias gcb='gradle clean bootRun'
alias gb='gradle bootRun'
alias node18='nvm install 18 && nvm use 18'
alias node20='nvm install 20 && nvm use 20'
alias node21='nvm install 21 && nvm use 21'
alias node22='nvm install 22 && nvm use 22'
alias node23='nvm install 23 && nvm use 23'
alias node24='nvm install 24 && nvm use 24'

alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias docker_clean='docker rm $(docker ps --filter=status=exited --filter=status=created -q) && docker rmi $(docker images -a --filter=dangling=true -q)'

# Alias system
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation

# alias edit='subl'                         # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias c='code .'

eval "$(/opt/homebrew/bin/brew shellenv)"

# --- SDKMAN (lazy-loaded: sdkman-init.sh costs ~2s per shell) ---
# Current candidates (java, gradle, ...) go straight on PATH so the tools
# work immediately; the real init only loads the first time `sdk` is run.
export SDKMAN_DIR="$HOME/.sdkman"
for _cand in "$SDKMAN_DIR"/candidates/*/current/bin(N); do
  PATH="$PATH:$_cand"
done
unset _cand
sdk() {
  unset -f sdk
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}

# --- nvm (lazy-loaded: nvm.sh costs ~5s per shell) ---
# nvm loads on the first use of nvm/node/npm/npx in a given shell,
# paying the cost once, only when actually needed.
export NVM_DIR="$HOME/.nvm"
_load_nvm() {
  unset -f nvm node npm npx _load_nvm 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm()  { _load_nvm; nvm "$@"; }
node() { _load_nvm; node "$@"; }
npm()  { _load_nvm; npm "$@"; }
npx()  { _load_nvm; npx "$@"; }

export JAVA_HOME=/Users/vwiencek/.sdkman/candidates/java/23-tem
