#!/bin/bash
set -ev
echo "Testing Build Process"
ls
cd JacobGathof/test-ci-repo
choco install docfx -y
docfx docfx/docfx.json