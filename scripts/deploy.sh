#!/bin/bash
set -e
echo "Testing Build Process"
cd JacobGathof/test-ci-repo
choco install docfx -y
docfx docfx/docfx.json