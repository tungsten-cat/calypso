#!/bin/bash

# Firstly, set path to a folder where you will build sources
sources_path=$1

# PUSHD is used to create directories stack

# It stores current directory to stack
# And walks to directory that specified as argument
pushd ${sources_path}

# Now make directory especialy for building GDB
mkdir build-gdb
cd build-gdb

# After that, we can configure GDB to build it for our platform
../gdb.x.y.z/configure \ 
    --target=${BUILD_TARGET} \ # BUILD_TARGET is specified in Dockerfile, running that script
    --prefix="${BUILD_PREFIX}" \ # BUILD_PREFIX is also specified in Dockerfile
    --disable-werror

# --disable-werror s a compiler flag that causes 
# all compiler warnings to be treated as errors

# All required components can be built using the following commands
make -j ${MAKE_JOBS} all-gdb
make -j ${MAKE_JOBS} install-gdb

# POPD returns you to the latest directory stored on stack
popd