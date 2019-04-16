#!/bin/bash
set -ev
echo "Testing Build Process"
ls
sudo apt-get install unzip
wget -O docfxzip.zip https://github.com/dotnet/docfx/releases/download/v2.41/docfx.zip
unzip docfxzip.zip -d ~/dfxd
ls
chmod +x ~/dfxd/docfx.exe
~/dfxd/docfx.exe docfx/docfx.json