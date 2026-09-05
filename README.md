# 🚀 osx-startup

Configuration complète d'un Mac neuf en une seule commande : environnement de
développement, applications, dotfiles et réglages macOS.

```shell
curl -sfL https://raw.githubusercontent.com/vwiencek/osx-startup/main/run.sh | sh
```

☕ Lancez la commande, validez l'installation des Command Line Tools et le mot de
passe sudo, puis laissez faire. Le script est **idempotent** : relançable sans danger.

## Ce qui est installé

| | |
|---|---|
| 🛠 **Outils** | Xcode CLT, Homebrew, git, gh, ripgrep, tmux, go, bun, azure-cli, cloudflared, tailscale, nmap, ffmpeg… |
| 🖥 **Apps** | iTerm2, VS Code, JetBrains Toolbox, Docker Desktop, Chrome, Firefox, Dropbox, Bitwarden, Slack, Notion, Signal, WhatsApp, Telegram, Spotify, VLC, OBS, Blender… |
| 🤖 **IA** | **Claude Code**, **Codex CLI**, **Antigravity**, **LM Studio**, **Ollama**, openclaw |
| ☕️ **Java** | SDKMAN : java 23-tem / 21-tem / GraalVM CE, gradle, maven |
| 🟢 **Node** | nvm + Node LTS |
| 🐚 **Shell** | oh-my-zsh + dotfiles (`.zshrc`, `.zshenv`, `.zprofile`, `.env.sh`) |
| ⚙️ **macOS** | Finder, Dock, clavier, trackpad, Safari, screenshots… |

## Installation à la carte

```shell
# Environnement de dev uniquement (brew, SDKMAN, nvm, Claude Code, Codex, dotfiles…)
curl -sfL https://raw.githubusercontent.com/vwiencek/osx-startup/main/bootstrap.sh | bash

# Réglages macOS uniquement (Finder, Dock, clavier…)
./run-first.sh

# Dotfiles uniquement
cp .zshrc .zshenv .zprofile .env.sh ~/
```

## Structure du repo

| Fichier | Rôle |
|---|---|
| `run.sh` | Point d'entrée : télécharge le repo puis enchaîne `bootstrap.sh` et `run-first.sh` |
| `bootstrap.sh` | Environnement de dev complet (idempotent) |
| `run-first.sh` | Réglages macOS (`defaults write`) |
| `Brewfile` | Formules et casks Homebrew |
| `.zshrc` / `.zshenv` / `.zprofile` / `.env.sh` | Dotfiles zsh |

## ⚡️ Un shell qui démarre en 0,7 s

Les dotfiles sont optimisés pour un démarrage quasi instantané (~0,7 s au lieu de 8–14 s) :

- **nvm** (~5 s) — lazy-load : `nvm`/`node`/`npm`/`npx` sont des stubs qui chargent
  le vrai `nvm.sh` au premier appel.
- **SDKMAN** (~2 s) — lazy-load : les candidats courants (`java`, `gradle`, …) sont mis
  directement sur le PATH ; `sdkman-init.sh` ne se charge qu'au premier `sdk`.
- **oh-my-zsh** — `ZSH_DISABLE_COMPFIX=true` saute l'audit de sécurité des complétions.
- La **sauvegarde Dropbox** de `.env.sh` tourne en tâche de fond détachée pour ne
  jamais bloquer le prompt.

## Après l'installation

Quelques logins restent à faire à la main :

```shell
gh auth login     # GitHub (requis par ~/.zshenv pour le token MCP)
claude            # Claude Code
codex login       # Codex
```

…et se connecter dans Dropbox, JetBrains Toolbox et Antigravity.

> ⚠️ Si vous migrez depuis une autre machine, gardez le même _username_ macOS
> pour que la récupération des paramètres se passe bien.
