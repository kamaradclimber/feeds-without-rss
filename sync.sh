#!/usr/bin/bash

set -ex

git pull origin main

ruby update_feeds.rb

git commit -a -m "Update jancovici feed source"

git push origin HEAD
