#!/bin/bash

# Clone Repo
echo
echo "Cloning mkdtimg repo"
echo
git clone https://github.com/ZeruxVayu/MKDTIMG.git mkdtimg
chmod +x mkdtimg/mkdtimg

echo
echo "Cloning Android Kernel Tools repo"
echo
git clone --depth=1 https://github.com/kdrag0n/proton-clang.git clang

echo
echo "Cloning Kernel Repo"
echo
git clone --depth=1 https://github.com/LineageOS/android_kernel_xiaomi_surya.git kernel

echo
echo "Setting up env"
echo

sudo apt-get install device-tree-compiler bc cpio ccache

mkdir -p out
export ARCH=arm64
export SUBARCH=arm64
export CLANG_PATH=~/clang/bin
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=$CLANG_PATH/aarch64-linux-gnu-
export CROSS_COMPILE_ARM32=$CLANG_PATH/arm-linux-gnueabi-

echo $CLANG_PATH

echo
echo "Moving to kernel dir"
echo

cd kernel

echo
echo "Clean Build Directory"
echo 

make clean && make mrproper

echo
echo "Issue Build Commands"
echo

mkdir -p out

echo
echo "Set DEFCONFIG"
echo 
make CC=clang O=out surya_defconfig

echo
echo "Build The Good Stuff"
echo 

make -j4 O=out CC="ccache clang" AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip Image.gz-dtb
