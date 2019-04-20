#!/bin/bash
set -ev
echo "Testing Build Process"

#sudo apt-get install unzip

#wget -O docfxzip.zip https://github.com/dotnet/docfx/releases/download/v2.41/docfx.zip
#unzip docfxzip.zip -d dfxd

#mono dfxd/docfx.exe docfx.json

#shopt -s extglob 
#rm -rf !(temp)
#cd temp
#mv * ../
#cd ..
#rm -rf temp

if [ "$TRAVIS_BRANCH" = "testing" ]; then
	echo "Running Tests, push to master"
  
	git config --global user.email "travis@travis-ci.org"
	git config --global user.name "Travis CI"

	git checkout -b master
	echo "Test" > test.txt
	git add .
	git commit -m "Travis build: $TRAVIS_BUILD_NUMBER"

	ls

	git push https://${GITHUB_API_KEY}@github.com/JacobGathof/test-ci-repo.git  
fi


if [ "$TRAVIS_BRANCH" = "master" ]; then
	echo "Running API Docs, push to gh-pages"
  
	git config --global user.email "travis@travis-ci.org"
	git config --global user.name "Travis CI"

	git checkout -b gh-pages
	echo "Test" > doc.txt
	git add .
	git commit -m "Travis build: $TRAVIS_BUILD_NUMBER"

	ls

	git push https://${GITHUB_API_KEY}@github.com/JacobGathof/test-ci-repo.git
	  
fi

