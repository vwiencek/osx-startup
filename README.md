## Utilisation

### Installation initiale de l'OS vierge

1. Installez macOS
1. Lancez le Mac App Store et connectez-vous à votre compte

⚠️ Attention, si vous migrez depuis une autre machine ou faites une réinstallation complète, utilisez tant que possible le même _username_, sinon Mackup ne fera pas les bonnes actions pour récupérer les paramètres des applications.

Tout-en-un (environnement de dev + réglages macOS) :

```shell
$ curl -sfL https://raw.githubusercontent.com/vwiencek/osx-startup/main/run.sh | sh
```

Ou séparément :

```shell
# Environnement de dev uniquement (brew, SDKMAN, nvm, Claude Code, Codex, dotfiles…)
$ curl -sfL https://raw.githubusercontent.com/vwiencek/osx-startup/main/bootstrap.sh | bash

# Réglages macOS uniquement (Finder, Dock, clavier…)
$ ./run-first.sh
```

### Ce que `bootstrap.sh` installe

- **Xcode Command Line Tools**
- **Homebrew** + le `Brewfile` : CLI (git, gh, ripgrep, tmux, go, bun, azure-cli, tailscale…)
  et casks — iTerm2, VS Code, JetBrains Toolbox, **Antigravity**, **LM Studio**, **Ollama**,
  Docker Desktop, navigateurs, Dropbox, apps de communication…
- **oh-my-zsh** + les dotfiles du repo (`.zshrc`, `.zshenv`, `.zprofile`, `.env.sh`)
- **SDKMAN** : java (23-tem, 21-tem, graalce), gradle, maven
- **nvm** : Node LTS
- **Claude Code** (installateur natif), **Codex CLI** et **openclaw** (npm)

Le script est idempotent : relançable sans danger. À la fin, il liste les
logins à faire à la main (`gh auth login`, `claude`, `codex login`, Dropbox…).

## Configuration zsh

Optimisée pour un démarrage rapide du shell (~0.7s au lieu de 8–14s) :

| Fichier | Destination | Rôle |
|---|---|---|
| `.zshrc` | `~/.zshrc` | oh-my-zsh (`ZSH_DISABLE_COMPFIX=true` pour sauter l'audit compaudit) |
| `.env.sh` | `~/.env.sh` | PATH, aliases, brew, SDKMAN + nvm (chargés paresseusement) |
| `.zshenv` | `~/.zshenv` | Exporte `GITHUB_PERSONAL_ACCESS_TOKEN` via `gh` pour le plugin GitHub MCP |
| `.zprofile` | `~/.zprofile` | Entrées PATH JetBrains Toolbox / Antigravity |

Optimisations :

- **nvm** (~5s) — lazy-load : `nvm`/`node`/`npm`/`npx` sont des fonctions stub qui chargent le vrai `nvm.sh` au premier appel.
- **SDKMAN** (~2s) — lazy-load : les candidats courants (`java`, `gradle`, …) sont mis directement sur le PATH ; `sdkman-init.sh` ne se charge qu'au premier `sdk`.
- **oh-my-zsh** — `ZSH_DISABLE_COMPFIX=true` saute l'audit de sécurité des répertoires de complétion.
- La **sauvegarde Dropbox** de `.env.sh` tourne en tâche de fond détachée pour ne jamais bloquer le prompt.

Installation :

```shell
$ cp .zshrc .zshenv .zprofile .env.sh ~/
```
