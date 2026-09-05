#!/bin/sh
#
# Point d'entrée depuis un Mac vierge :
#   curl -sfL https://raw.githubusercontent.com/vwiencek/osx-startup/main/run.sh | sh
#
# Télécharge le repo puis lance bootstrap.sh (environnement de dev)
# et run-first.sh (réglages macOS).

set -e

DIR="$HOME/.osx-init"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

curl -sfL https://github.com/vwiencek/osx-startup/archive/main.zip -o main.zip
unzip -qj main.zip
rm main.zip run.sh

chmod +x bootstrap.sh run-first.sh
./bootstrap.sh
./run-first.sh

echo ""
echo "Bootstrap terminé — ouvrez un nouveau terminal."
