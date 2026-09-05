#!/bin/bash
#
# Bootstrap d'un Mac neuf — environnement de dev complet.
# Idempotent : peut être relancé sans danger, chaque étape vérifie l'existant.
#
# Utilisation (depuis un laptop vierge) :
#   curl -sfL https://raw.githubusercontent.com/vwiencek/osx-startup/main/bootstrap.sh | bash
#
# Ou depuis un clone du repo :
#   ./bootstrap.sh
#
# Installe : Xcode CLT, Homebrew (+ Brewfile : casks dont Antigravity, LM Studio,
# Ollama, Docker, iTerm2…), oh-my-zsh, dotfiles (.zshrc/.zshenv/.zprofile/.env.sh),
# SDKMAN (java/gradle/maven), nvm (node LTS), Claude Code, Codex, openclaw.
#
# Les réglages macOS (Finder, Dock, …) restent dans run-first.sh.

set -uo pipefail

REPO_RAW="https://raw.githubusercontent.com/vwiencek/osx-startup/main"

log()  { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
ok()   { printf '\033[1;32m    ✓ %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m    ! %s\033[0m\n' "$*"; }

# Récupère un fichier du repo : copie locale si on est dans le clone, sinon curl.
fetch() { # fetch <fichier> <destination>
  local src dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)"
  if [ -f "$dir/$1" ]; then
    cp "$dir/$1" "$2"
  else
    curl -sfL "$REPO_RAW/$1" -o "$2"
  fi
}

# ---------------------------------------------------------------- Xcode CLT
install_xcode_clt() {
  log "Xcode Command Line Tools"
  if xcode-select -p >/dev/null 2>&1; then
    ok "déjà installés"
  else
    xcode-select --install
    warn "Validez la fenêtre d'installation, le script attend…"
    until xcode-select -p >/dev/null 2>&1; do sleep 15; done
    ok "installés"
  fi
}

# ---------------------------------------------------------------- Homebrew
install_brew() {
  log "Homebrew"
  if [ -x /opt/homebrew/bin/brew ]; then
    ok "déjà installé"
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew update
}

install_brew_bundle() {
  log "Brewfile (formules + casks : Antigravity, LM Studio, Ollama, Docker…)"
  fetch Brewfile /tmp/Brewfile
  brew bundle --file=/tmp/Brewfile || warn "certains paquets du Brewfile ont échoué (voir ci-dessus)"
}

# ---------------------------------------------------------------- zsh + dotfiles
install_zsh() {
  log "oh-my-zsh"
  if [ -d "$HOME/.oh-my-zsh" ]; then
    ok "déjà installé"
  else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
}

install_dotfiles() {
  log "Dotfiles (.zshrc, .zshenv, .zprofile, .env.sh — startup optimisé ~0.7s)"
  for f in .zshrc .zshenv .zprofile .env.sh; do
    [ -f "$HOME/$f" ] && cp "$HOME/$f" "$HOME/$f.pre-bootstrap"
    fetch "$f" "$HOME/$f"
  done
  ok "installés (anciens fichiers sauvegardés en *.pre-bootstrap)"
}

# ---------------------------------------------------------------- SDKMAN / Java
install_sdkman() {
  log "SDKMAN + Java / Gradle / Maven"
  if [ ! -d "$HOME/.sdkman" ]; then
    curl -s "https://get.sdkman.io" | bash
  fi
  sed -i '' -e 's/sdkman_auto_answer=false/sdkman_auto_answer=true/g' "$HOME/.sdkman/etc/config" 2>/dev/null
  set +u
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk install gradle
  sdk install maven
  # 23-tem = JAVA_HOME dans .env.sh ; ajuster si SDKMAN ne le propose plus (sdk list java)
  sdk install java 23-tem        || warn "java 23-tem indisponible — installez à la main (sdk list java) et ajustez JAVA_HOME dans ~/.env.sh"
  sdk install java 21.0.9-tem    || warn "java 21.0.9-tem indisponible"
  sdk install java 25.1.3-graalce || warn "java 25.1.3-graalce indisponible — ajustez GRAALVM_HOME dans ~/.env.sh"
  set -u
}

# ---------------------------------------------------------------- nvm / Node
install_nvm() {
  log "nvm + Node LTS"
  if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  fi
  export NVM_DIR="$HOME/.nvm"
  set +u
  \. "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm alias default 'lts/*'
  set -u
}

# ---------------------------------------------------------------- Outils IA
install_ai_tools() {
  log "Claude Code"
  if command -v claude >/dev/null 2>&1 || [ -x "$HOME/.local/bin/claude" ]; then
    ok "déjà installé"
  else
    curl -fsSL https://claude.ai/install.sh | bash
  fi

  log "Codex CLI"
  npm install -g @openai/codex || warn "installation de codex échouée"

  log "openclaw"
  npm install -g openclaw || warn "installation d'openclaw échouée"

  # Antigravity, LM Studio et Ollama sont installés en casks via le Brewfile.
}

# ---------------------------------------------------------------- Fin
finish() {
  log "Terminé !"
  echo "  Reste à faire à la main :"
  echo "   - gh auth login          (GitHub — requis par ~/.zshenv pour le token MCP)"
  echo "   - claude                 (login Claude Code)"
  echo "   - codex login"
  echo "   - Dropbox, JetBrains Toolbox, Antigravity : se connecter"
  echo "   - Réglages macOS : ./run-first.sh (Finder, Dock, clavier…)"
  echo ""
  echo "  Ouvrez un nouveau terminal pour charger la config zsh."
}

install_xcode_clt
install_brew
install_brew_bundle
install_zsh
install_dotfiles
install_sdkman
install_nvm
install_ai_tools
finish
