# Firstly, choose which distro image to use for compiling
# Also you should specify base image version for container
ARG BASE_IMAGE=ubuntu 
ARG IMAGE_VERSION=latest

# Create container using base image from hub.docker.com
FROM ${BASE_IMAGE}:${IMAGE_VERSION}

# Setting target platform for cross compiler
ENV BUILD_TARGET x86_64-elf

# Also set versions for GCC and Binutils
ENV BINUTILS_VERSION X
ENV GCC_VERSION X

# Update all system packages
# to the latest available version
RUN apt-get update
RUN apt-get upgrade -y

# Install needed packages to build cross compiler
RUN apt-get install -y \
    build-essentials bison flex texinfo wget \
    libgmp3-dev libmpc-dev libmpfr-dev



