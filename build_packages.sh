#!/bin/env bash

pkgbuilds="/pkg"
repo="/repo"
start_dir=$PWD

cd $pkgbuilds

for package in $(ls)
do
	cd $package
	makepkg -s --noconfirm
	repo-add "$repo/lnclt.db.tar.xz" *.pkg.tar.gz
	cp *.pkg.tar.gz "$repo/"
	cd $start_dir
done
