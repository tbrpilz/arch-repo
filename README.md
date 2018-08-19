## PKGBUILDS for lnc.lt custom arch repository

This repository contains PKGBUILDs for all the packages on https://arch.lnc.lt as well as a Dockerfile to build the repository. The packages are mostly meta-packages, allowing for easy, modular scaffolding of different Arch Linux installs.

### Usage

* Via Docker
  Dependencies:
	 * Docker
  Run `docker run -v "$PWD/repo:/repo" lnclt/arch-repo`. This uses a custom Docker image.
* On host system
  Dependencies:
	* Arch Linux
	* base-devel package group installed
	* aurutils (aur)
	Run `./build_packages.sh`. Ensure the proper pkg and repo paths are set inside the script.


