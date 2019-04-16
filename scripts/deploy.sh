#!/bin/bash
set -ev
echo "Testing Build Process"
choco install docfx -y
docfx docfx/docfx.json