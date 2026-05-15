#! /usr/bin/env bash

#grep repo
mkdir ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
sudo ln -sf ~/bin/repo /usr/bin/repo

#setup author
git config --global user.name "rsuntk"
git config --global user.email "noreply@github.com"

#syncing
repo init --depth=1 --no-repo-verify --git-lfs -u https://github.com/TWRP-Test/platform_manifest_twrp_aosp.git -b twrp-16.0 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
