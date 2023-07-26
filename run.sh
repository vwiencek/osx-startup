#!/bin/sh

mkdir $HOME/.osx-init/
cd $HOME/.osx-init
curl -sL https://github.com/vwiencek/osx-startup/archive/master.zip -o master.zip
unzip -qj master.zip
rm master.zip run.sh
chmod +x run-first.sh
./run-first.sh
