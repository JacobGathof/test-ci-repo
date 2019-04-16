#!/bin/bash
set -ev
echo "Testing Build Process"

sudo apt-get update
sudo apt-get install unzip
sudo apt-get install mono-devel

wget -O docfxzip.zip https://github.com/dotnet/docfx/releases/download/v2.41/docfx.zip
unzip docfxzip.zip -d dfxd

mono dfxd/docfx.exe docfx/docfx.json