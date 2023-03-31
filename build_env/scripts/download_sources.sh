#!/bin/bash

# Firstly, set path to a folder where you will download sources
downloading_path=$1

# PUSHD is used to create directories stack

# It stores current directory to stack
# And walks to directory that specified as argument
pushd ${downloading_path}

# Using WGET we can download sources of binutils
# With TAR will unpack archive containing sources
wget -q https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.xz
tar -xf binutils-${BINUTILS_VERSION}.tar.xz

# As well as for GDB source code
wget -q https://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.xz
tar -xf gdb-${GDB_VERSION}.tar.xz

# The same for GCC sources
wget -q https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.xz
tar -xf gcc-${GCC_VERSION}.tar.xz

# After unpacking sources we can remove downloaded files
rm binutils-${BINUTILS_VERSION}.tar.xz
rm gdb-${GDB_VERSION}.tar.xz
rm gcc-${GCC_VERSION}.tar.xz

# POPD returns you to the latest directory stored on stack
popd