# Error out if the required fields aren't specified

# When building using Make, you should specify BUILD_TARGET
# Which contains architecture of a targeting machine (i.e. x86, arm, etc.)
ifndef BUILD_TARGET
	$(error "BUILD_TARGET is not available! You can pass it as environment variable by typing BUILD_TARGET=...")
endif

# Set variables for unified build process
# You can change this values, but the build process will work properly

# Setting compiler for C and C++ files
CC := $(BUILD_TARGET)-gcc

# Setting compiler for Assembly files
ASC := nasm

# Setting BASE directory, which contains this Makefile
BASE_DIRECTORY := $(PWD)

# Setting OBJECT_DIRECTORY, which contains compiled object files
# Also setting RELEASE_DIRECTORY, where linked binaries will be stored
OBJECTS_DIRECTORY := $(BASE_DIRECTORY)/build/$(BUILD_TARGET)
RELEASE_DIRECTORY := $(BASE_DIRECTORY)/release/$(BUILD_TARGET)


