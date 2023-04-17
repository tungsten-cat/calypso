ifndef TARGET_ARCH
$(error "TARGET_ARCH is not available! You can pass it as environment variable by typing TARGET_ARCH=...")
endif

AS := nasm

AS_FLAGS := -f bin

CC := $(TARGET_ARCH)-elf-gcc
LD := $(TARGET_ARCH)-elf-ld

CC_FLAGS := --ffreestanding

# Setting BASE directory, which contains this Makefile
BASE_DIRECTORY := $(PWD)

# After that we'll set path to SOURCES folder
SOURCES_DIRECTORY := $(BASE_DIRECTORY)/sources/

# Setting BUILD_DIRECTORY, which contains compiled binary files
# Also setting RELEASE_DIRECTORY, where linked binaries will be stored
BUILD_DIRECTORY := $(BASE_DIRECTORY)/build/
RELEASE_DIRECTORY := $(BASE_DIRECTORY)/release/

