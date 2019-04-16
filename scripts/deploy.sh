#!/bin/bash
set -e
echo "Testing Build Process"

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"


if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    exit 0
fi


REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`


git clone $REPO out
cd out
git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH
find -maxdepth 1 ! -name .git ! -name . | xargs rm -rf
cd ..


cd out
git config user.name "Travis CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"


if git diff --quiet; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi


git add -A .
git commit -m "Deploy to GitHub Pages: ${SHA}"
git push $SSH_REPO $TARGET_BRANCH

