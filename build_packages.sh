#!/bin/env bash

pkgbuilds="pkg"
repo="repo"
root=$PWD

cd $pkgbuilds

for package in $(ls $root/pkg)
do
	cd $package

	#Create package
	makepkg -s --noconfirm

	#Add package information to repo
	repo-add "$root/$repo/lnclt.db.tar.xz" *.pkg.tar.gz

	#Add package to repo
	mv *.pkg.tar.gz "$root/$repo/"

	#Clean up
	rm -rf {pkg,src}
	cd $start_dir
done
