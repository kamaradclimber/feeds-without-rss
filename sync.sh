#!/usr/bin/bash

set -ex

git pull origin main

ruby update_feeds.rb
git add feeds.toml

if [[ "$(git diff --no-ext-diff --cached)" != "" ]]; then
  git commit -a -m "Update jancovici feed source"
  git push origin HEAD
fi

