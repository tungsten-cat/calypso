#!/bin/bash

# Firstly, set path to a folder where you will build sources
sources_path=$1

# PUSHD is used to create directories stack

# It stores current directory to stack
# And walks to directory that specified as argument
pushd ${sources_path}

# Now make directory especialy for building BINUTILS
mkdir build-binutils
cd build-binutils

# After that, we can configure BINUTILS to build it for our platform
../binutils-${BINUTILS_VERSION}/configure \
    --target=${BUILD_TARGET} \ # BUILD_TARGET is specified in Dockerfile, running that script
    --prefix="${BUILD_PREFIX}" \ # BUILD_PREFIX is also specified in Dockerfile
    --with-sysroot --disable-nls --disable-werror

# --disable-nls tells binutils not to include native language support
# This flag reduces dependencies and compilation time

# All required components can be built using the following commands
make -j ${MAKE_JOBS}
make -j ${MAKE_JOBS} install

# POPD returns you to the latest directory stored on stack
popd