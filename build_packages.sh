#!/bin/env bash

pkg="pkg"
repo="repo"
root=$PWD

cd $pkg

for package in $(ls $root/$pkg)
do
	cd $package

	#Create package binary
	makepkg -s -c --noconfirm

	#Add package information to repo
	repo-add "$root/$repo/lnclt.db.tar.xz" *.pkg.tar.gz

	#Add package to repo
	mv *.pkg.tar.gz "$root/$repo/"

	#Clean up
	cd $root
done
