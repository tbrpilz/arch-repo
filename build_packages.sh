#!/bin/env bash

pkgbuilds="/pkg"
repo="/repo/lnclt.db.tar.xz"
start_dir=$PWD

cd $pkgbuilds

for package in $(ls)
do
	cd $package
	makepkg -s --noconfirm
	repo-add $repo *.pkg.tar.gz
	cd $start_dir
done
