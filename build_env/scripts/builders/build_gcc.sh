#!/bin/bash

# Firstly, set path to a folder where you will build sources
sources_path=$1

# PUSHD is used to create directories stack

# It stores current directory to stack
# And walks to directory that specified as argument
pushd ${sources_path}

# Now make directory especialy for building GCC
mkdir build-gcc
cd build-gcc

# After that, we can configure GCC to build it for our platform
echo "Configuring GCC..."

../gcc-${GCC_VERSION}/configure \
    --target=${BUILD_TARGET} \
    --prefix="${BUILD_PREFIX}" \
    --disable-nls --enable-languages=c,c++ --without-headers

# BUILD_TARGET is specified in Dockerfile, running that script
# BUILD_PREFIX is also specified in Dockerfile

# --disable-nls tells binutils not to include native language support
# This flag reduces dependencies and compilation time

# --enable-languages tells GCC not to compile 
# all the other language frontends it supports

# --without-headers tells GCC 
# not to rely on any C library being present for the target

# With basic GCC components we also building LIBGCC
# Which is a low-level support library that the compiler expects at compile time
echo "Building GCC..."
make -j ${MAKE_JOBS} all-gcc
make -j ${MAKE_JOBS} all-target-libgcc

echo "Installing GCC..."
make -j ${MAKE_JOBS} install-gcc
make -j ${MAKE_JOBS} install-target-libgcc

# Note that we aren't running make && make install
# as that would build way too much for our operating system. 

# POPD returns you to the latest directory stored on stack
popd