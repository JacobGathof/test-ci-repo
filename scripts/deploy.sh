#!/bin/bash
set -ev
echo "Testing Build Process"
ls
choco install docfx -y
docfx docfx/docfx.json