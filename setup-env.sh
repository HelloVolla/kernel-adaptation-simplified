#!/bin/bash
# Source this before rpmbuild to fetch the android build tools and export
# the toolchain environment.

export BUILD_TOOLS=${BUILD_TOOLS:-~/android-build-tools}
BUILD_TOOLS_BRANCH=${BUILD_TOOLS_BRANCH:-master-kernel-build-2022}
CLANG_BRANCH=${CLANG_BRANCH:-android12L-gsi}
CLANG_VERSION=${CLANG_VERSION:-clang-r416183b}

mkdir -p $BUILD_TOOLS

[ -e $BUILD_TOOLS/aarch64-linux-android-4.9 ] || git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b pie-gsi $BUILD_TOOLS/aarch64-linux-android-4.9 --depth 1 --recursive
[ -e $BUILD_TOOLS/arm-linux-androideabi-4.9 ] || git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 -b pie-gsi $BUILD_TOOLS/arm-linux-androideabi-4.9 --depth 1 --recursive
[ -e $BUILD_TOOLS/linux-x86 ] || git clone https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86 -b $CLANG_BRANCH $BUILD_TOOLS/linux-x86 --depth 1 --recursive
[ -e $BUILD_TOOLS/avb ] || git clone https://android.googlesource.com/platform/external/avb -b android13-gsi $BUILD_TOOLS/avb --depth 1 --recursive
[ -e $BUILD_TOOLS/build-tools ] || git clone https://android.googlesource.com/platform/prebuilts/build-tools -b $BUILD_TOOLS_BRANCH $BUILD_TOOLS/build-tools --depth 1 --recursive
[ -e $BUILD_TOOLS/kernel-build-tools ] || git clone https://android.googlesource.com/kernel/prebuilts/build-tools -b $BUILD_TOOLS_BRANCH $BUILD_TOOLS/kernel-build-tools --depth 1 --recursive
[ -e $BUILD_TOOLS/android_system_tools_mkbootimg ] || git clone https://github.com/LineageOS/android_system_tools_mkbootimg -b lineage-20.0 $BUILD_TOOLS/android_system_tools_mkbootimg --depth 1 --recursive
[ -e $BUILD_TOOLS/2.7.5 ] || git clone https://android.googlesource.com/platform/prebuilts/python/linux-x86/2.7.5/ $BUILD_TOOLS/2.7.5 --depth 1 --recursive

export CLANG_PATH=$BUILD_TOOLS/linux-x86/$CLANG_VERSION/bin/
export BUILD_TOOLS_BIN=$BUILD_TOOLS/build-tools/linux-x86/bin
export BUILD_TOOLS_PATH=$BUILD_TOOLS/build-tools/path/linux-x86
export KERNEL_BUILD_TOOLS_BIN=$BUILD_TOOLS/kernel-build-tools/linux-x86/bin
export GCC_PATH=$BUILD_TOOLS/aarch64-linux-android-4.9/bin
export GCC_ARM32_PATH=$BUILD_TOOLS/arm-linux-androideabi-4.9/bin
export AVB_PATH=$BUILD_TOOLS/avb
export MKBOOTIMG_PATH=$BUILD_TOOLS/android_system_tools_mkbootimg
export PYTHON2_PATH=$BUILD_TOOLS/2.7.5/bin
export PATH=$CLANG_PATH:$BUILD_TOOLS_BIN:$KERNEL_BUILD_TOOLS_BIN:$GCC_PATH:$GCC_ARM32_PATH:$AVB_PATH:$MKBOOTIMG_PATH:$PYTHON2_PATH:$PATH
