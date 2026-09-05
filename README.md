## Utilisation

### Installation initiale de l'OS vierge


1. Installez macOS
1. Lancez le Mac App Store et connectez-vous à votre compte

⚠️ Attention, si vous migrez depuis une autre machine ou faites une réinstallation complète, utilisez tant que possible le même _username_, sinon Mackup ne fera pas les bonnes actions pour récupérer les paramètres des applications.


```shell
$ curl -sfL https://raw.githubusercontent.com/vwiencek/osx-startup/main/run.sh | sh
```

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
