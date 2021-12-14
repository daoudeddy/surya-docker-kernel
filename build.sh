#!/bin/bash

# Clone Repo
echo
echo "Cloning mkdtimg repo"
echo
#git clone https://github.com/ZeruxVayu/MKDTIMG.git mkdtimg

echo
echo "Cloning Android Kernel Tools repo"
echo
#git clone --depth=1 https://github.com/pkm774/android-kernel-tools tools

echo
echo "Cloning Kernel Repo"
echo
#git clone https://github.com/freak07/Kirisakura_Bluecross.git -b Release_R_1 kernel

echo
echo "Setting up env"
echo

PATH="$PWD/tools/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$PATH"
PATH="$PWD/tools/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin:$PATH"
PATH="$PWD/mkdtimg:$PATH"
export PATH="$PWD/tools/clang/host/linux-x86/clang-r428724/bin:$PATH"
export LD_LIBRARY_PATH="$PWD/tools/clang/host/linux-x86/clang-r428724/lib64:$LD_LIBRARY_PATH"
export ARCH=arm64
export SUBARCH=ARM64
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=aarch64-linux-android-
export CROSS_COMPILE_ARM32=arm-linux-androideabi-

echo
echo "Moving to kernel dir"
echo

cd kernel

echo
echo "Clean Build Directory"
echo 

#make clean && make mrproper

echo
echo "Issue Build Commands"
echo

mkdir -p out

echo
echo "Set DEFCONFIG"
echo 
# make CC=clang O=out kirisakura_defconfig
make CC=clang O=out b1c1_defconfig

echo
echo "Build The Good Stuff"
echo 

make CC=clang O=out -j4
