#!/bin/bash
set -ev
echo "Testing Build Process"
ls
brew install docfx
docfx docfx/docfx.json