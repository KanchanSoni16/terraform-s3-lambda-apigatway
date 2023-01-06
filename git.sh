#!/bin/bash
git clone git@github.com:KanchanSoni16/awesome_project.git
rsync -av --exclude 'awesome_project' --exclude '.terraform' ./ ./awesome_project/
cd awesome_project
git add .
git commit -m "Pushing code in github repo"
git push git@github.com:KanchanSoni16/awesome_project.git