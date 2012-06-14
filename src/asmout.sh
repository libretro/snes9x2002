#!/bin/bash

if [ "$2" == "caanoo" ]; then
	echo Using Caanoo toolkit
	ARCH="arm-gph-linux-gnueabi"
	SDK="/opt/caanoo_sdk/tools/gcc-4.2.4-glibc-2.7-eabi/"
	MACHINE="caanoo"
else
	echo Using Wiz toolkit
	ARCH="arm-open2x-linux"
	SDK="/opt/open2x/gcc-4.1.1-glibc-2.3.6/"
	MACHINE="wiz"
fi

GCC="$SDK/bin/$ARCH-gcc"

COPT="-mcpu=arm926ej-s -mtune=arm926ej-s -g -D__WIZ__"
COPT="$COPT -DASMCPU -DARM"
COPT="$COPT -Os"
COPT="$COPT -ffast-math -msoft-float"
COPT="$COPT -finline -finline-functions -fexpensive-optimizations" 
COPT="$COPT -falign-functions=32 -falign-loops -falign-labels -falign-jumps"
COPT="$COPT -fomit-frame-pointer"
COPT="$COPT -fno-common -fno-builtin -fstrict-aliasing -mstructure-size-boundary=32" 
#COPT="$COPT -O3"
#COPT="$COPT -ffast-math  -msoft-float"
#COPT="$COPT -finline-functions"
#COPT="$COPT -finline -fexpensive-optimizations" 
#COPT="$COPT -falign-functions=32 -falign-loops -falign-labels -falign-jumps" 
#COPT="$COPT -fomit-frame-pointer"
COPT="$COPT -I$SDK/include"
COPT="$COPT -L$SDK/lib"


# -c -g -Wa,-a,-ad
$GCC -c -Wa,-ahl=$1.commented.$MACHINE.s $1.cpp $COPT
$GCC  -S -c -o $1.generated.$MACHINE.s $1.cpp $COPT
