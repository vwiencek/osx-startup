export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
plugins=(git)

# Skip compaudit security scan of completion dirs (major startup cost)
ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

source ~/.env.sh

export PATH="$HOME/.local/bin:$PATH"

# OpenClaw Completion
[ -f "/Users/vwiencek/.openclaw/completions/openclaw.zsh" ] && source "/Users/vwiencek/.openclaw/completions/openclaw.zsh"


# Added by Antigravity CLI installer
export PATH="/Users/vwiencek/.local/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/vwiencek/.lmstudio/bin"
# End of LM Studio CLI section
