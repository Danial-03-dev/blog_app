#!/bin/bash

# Prevent Git Bash from rewriting / paths
export MSYS_NO_PATHCONV=1

# Your repo name
REPO_NAME="blog_app"

# Build Flutter Web
flutter build web --release --base-href "/$REPO_NAME/"

# Go to build folder
cd build/web

# Deploy to gh-pages
git init
git checkout -b gh-pages
git add .
git commit -m "deploy(web)"
git remote add origin https://github.com/Danial-03-dev/$REPO_NAME.git
git push -f origin gh-pages
