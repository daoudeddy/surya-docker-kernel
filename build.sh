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
git clone --depth=1 https://github.com/pkm774/android-kernel-tools tools
git clone --depth=1 https://github.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-5696680.git clang

echo
echo "Cloning Kernel Repo"
echo
git clone https://github.com/freak07/Kirisakura_Bluecross.git -b Release_3.1 kernel

echo
echo "Setting up env"
echo

sudo apt install -y device-tree-compiler bc

mkdir -p out
export ARCH=arm64
export SUBARCH=arm64
export CLANG_PATH=$PWD/clang/bin
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=$PWD/tools/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=$PWD/tools/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-

echo
echo "Moving to kernel dir"
echo

cd kernel

echo
echo "Patching Files"
echo

git apply ../kernel.patch
cp ../b1c1-docker_defconfig arch/arm64/configs/
cp ../wireguard.tar ./
tar -xvf wireguard.tar

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
make CC=clang O=out b1c1-docker_defconfig

echo
echo "Build The Good Stuff"
echo 

make CC=clang O=out -j4
