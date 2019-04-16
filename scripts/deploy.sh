#!/bin/bash
set -ev
echo "Testing Build Process"
ls
sudo apt-get install unzip
wget -O docfxzip.zip https://github.com/dotnet/docfx/releases/download/v2.41/docfx.zip
mkdir dfxd
unzip docfxzip.zip -d dfxd
dfxd/docfx.exe docfx/docfx.json