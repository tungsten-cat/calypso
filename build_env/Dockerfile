# Firstly, choose which distro image to use for compiling
# Also you should specify base image version for container
ARG BASE_IMAGE=ubuntu 
ARG IMAGE_VERSION=latest

# Create container using base image from hub.docker.com
FROM ${BASE_IMAGE}:${IMAGE_VERSION}

# Setting target platform for cross compiler
ARG BUILD_TARGET=x86_64-elf

# To specify target while building
# Run build command with --build-arg flag

# Example: --build-arg BUILD_TARGET=x86_64-elf

# On a multi-core machine you can speed up the build
# By parallelising it using this parameter

# This parameter sets how many jobs to run simultaneously
ARG USER_MAKE_JOBS=8
ENV MAKE_JOBS ${USER_MAKE_JOBS}

# Also set versions for GCC, GDB and Binutils
ENV BINUTILS_VERSION 2.40
ENV GDB_VERSION 13.1
ENV GCC_VERSION 12.2.0

# Update all system packages
# to the latest available version
RUN apt-get update
RUN apt-get upgrade -y

# Install needed packages to build cross compiler
RUN apt-get install -y \
    build-essential bison flex texinfo wget nasm \
    libgmp3-dev libmpc-dev libmpfr-dev

# Set compiler installation directory
ENV BUILD_PREFIX=/usr/local/cross
RUN mkdir -p ${BUILD_PREFIX}

# Also, we should add compiler to PATH for later usage
ENV PATH="${BUILD_PREFIX}/bin:$PATH"

# Copy building scripts to our container
# And add them to PATH 
COPY scripts /scripts
ENV PATH="/scripts:/scripts/builders:$PATH"

# Finally, run our building scripts
# After executing, remove temporary files
RUN mkdir -p /sources

RUN download_sources.sh /sources && \
    build_binutils.sh /sources && build_gdb.sh /sources && build_gcc.sh /sources \
    rm -rf /sources && rm -rf /scripts