# Error out if the required fields aren't specified

# For build we'll require user to specify TARGET_ARCH
# Which is the first field of target triplet (amd64, arm, etc.) 
ifndef TARGET_ARCH
	$(error "TARGET_ARCH is not available! You can pass it as environment variable by typing TARGET_ARCH=...")
endif

# Set variables for unified build process
# You can change this values, but the build process will work properly

# Setting compiler for Assembly files
AS := nasm

# Also we'll set flags for executing our compiler
AS_FLAGS := -f bin

# Setting compiler for C and C++ files
CC := $(TARGET_ARCH)-none-eabi-gcc

# The same for C and C++ compiling flags
CC_FLAGS := -nostdlib -ffreestanding

# And finally setting linker for target platform
LD := $(TARGET_ARCH)-none-eabi-ld

# Setting BASE directory, which contains this Makefile
BASE_DIRECTORY := $(PWD)

# After that we'll set path to SOURCES folder
SOURCES_DIRECTORY := $(BASE_DIRECTORY)/sources/

# Setting BUILD_DIRECTORY, which contains compiled binary files
# Also setting RELEASE_DIRECTORY, where linked binaries will be stored
BUILD_DIRECTORY := $(BASE_DIRECTORY)/build/$(BUILD_TARGET)
RELEASE_DIRECTORY := $(BASE_DIRECTORY)/release/$(BUILD_TARGET)

# Collecting platform specific ASM source files, 
TARGET_ASM_SOURCE_FILES := $(shell find $(SOURCES_DIRECTORY)/arch/$(TARGET_ARCH) -name *.asm)

# Collecting universal ASM files
ASM_SOURCE_FILES := $(TARGET_ASM_SOURCE_FILES) $(filter-out $(TARGET_ASM_SOURCE_FILES) $(shell find $(SOURCES_DIRECTORY) -name *.asm)) 
ASM_OBJECT_FILES := $(patsubst $(SOURCES_DIRECTORY)/%.asm, $(BUILD_DIRECTORY)/%.bin, $(ASM_SOURCE_FILES))