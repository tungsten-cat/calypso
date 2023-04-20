
# First of all, check if required ENV variables were passed
ifndef TARGET_ARCH
# Throw error if user hasn't specified TARGET_ARCH variable
$(error "TARGET_ARCH is not available! You can pass it as environment variable by typing TARGET_ARCH=...")
endif

# Next, declare variables for universal build

# This field specifies assembly compiler
AS := nasm
# And flags for this compiler to run
AS_FLAGS := -f elf64

# Next, we define variable with compiler for C
CC := $(TARGET_ARCH)-elf-gcc
# Also declaring flags for C compiler to run
CC_FLAGS := -c -ffreestanding

# After building, we'll also link everything to a single kernel file
# So we should define variable, pointing to linking utility
LD := $(TARGET_ARCH)-elf-ld
# Also we should declare flags for linker, as well as for compilers
LD_FLAGS := -n

# NOTE: ALL ADDRESSES SHOULD NOT CONTAIN "/"
# AT THE END OF PATH TO THE DIRECTROY 

# Setting BASE directory, which contains this Makefile
BASE_DIRECTORY := $(PWD)

# After that we'll set path to SOURCES folder
SOURCES_DIRECTORY := $(BASE_DIRECTORY)/sources

# Setting BUILD_DIRECTORY, which contains compiled binary files
BUILD_DIRECTORY := $(BASE_DIRECTORY)/build
# Also setting RELEASE_DIRECTORY, where linked binaries will be stored
RELEASE_DIRECTORY := $(BASE_DIRECTORY)/release

# Next, we'll set directory with requirements for targeting architecture
TARGET_DIRECTORY := $(BASE_DIRECTORY)/targets/$(TARGET_ARCH)

# After that we will collect source files to build our kernel

# Since some files can be different for some architectures
# So we should collect files for targeting architecture separately
TARGET_ASM_SOURCE_FILES := $(shell find $(SOURCES_DIRECTORY)/arch/$(TARGET_ARCH) -name *.asm)
# And after that, we'll collect list of compiled files
# By replacing paths to the files in SOURCES directory with paths to BUILD directory
TARGET_ASM_OBJECT_FILES := $(patsubst $(SOURCES_DIRECTORY)/arch/$(TARGET_ARCH)/%.asm, $(BUILD_DIRECTORY)/$(TARGET_ARCH)/%.o, $(TARGET_ASM_SOURCE_FILES))

# Next, we should do the same for "universal" assembly files 
UNIVERSAL_ASM_SOURCE_FILES := $(filter-out $(TARGET_ASM_SOURCE_FILES), $(shell find $(SOURCES_DIRECTORY) -name *.asm))
# And as well as for platform-dependent files, we'll collect list of compiled files 
UNIVERSAL_ASM_OBJECT_FILES := $(patsubst $(SOURCES_DIRECTORY)/%.asm, $(BUILD_DIRECTORY)/%.o, $(UNIVERSAL_ASM_SOURCE_FILES))

# Next we'll describe compiling scripts for assembly files

# This script will compile platform-specific assembly files
$(TARGET_ASM_OBJECT_FILES): $(BUILD_DIRECTORY)/$(TARGET_ARCH)/%.o : $(SOURCES_DIRECTORY)/arch/$(TARGET_ARCH)/%.asm
# First of all, we'll create folder under BUILD_DIRECTORY
# That'll be similar to path under SOURCES_DIRECTORY
	mkdir -p $(dir $@)
# And our next step is to run AS, to compile assembly files
	$(AS) $(AS_FLAGS) $(patsubst $(BUILD_DIRECTORY)/$(TARGET_ARCH)/%.o, $(SOURCES_DIRECTORY)/arch/$(TARGET_ARCH)/%.asm, $@) -o $@

# This script will compile "universal" assembly files
$(UNIVERSAL_ASM_OBJECT_FILES): $(BUILD_DIRECTORY)/%.o : $(SOURCES_DIRECTORY)/%.asm
# First of all, we'll create folder under BUILD_DIRECTORY
# That'll be similar to path under SOURCES_DIRECTORY
	mkdir -p $(dir $@)
# And our next step is to run AS, to compile assembly files
	$(AS) $(AS_FLAGS) $(patsubst $(BUILD_DIRECTORY)/%.o, $(SOURCES_DIRECTORY)/%.asm, $@) -o $@

# Finally, we'll collect all our compiled files under one variable
ASM_OBJECT_FILES := $(TARGET_ASM_OBJECT_FILES) $(UNIVERSAL_ASM_OBJECT_FILES)

# This command compiles our kernel for AMD64 system

# We'll make this target PHONY, which means this command is always outdated
# It's useful because we'll rebuild our kernel every time this command runs
.PHONY: build-amd64
build-amd64: $(ASM_OBJECT_FILES)
# First of all, we'll create directory for our built kernel
	mkdir -p $(RELEASE_DIRECTORY)/$(TARGET_ARCH)
# Next, we'll link everything to a single binary file, which is almost a working system 
	$(LD) $(LD_FLAGS) -o $(RELEASE_DIRECTORY)/$(TARGET_ARCH)/calypso-$(TARGET_ARCH).bin -T $(TARGET_DIRECTORY)/linker.ld $(ASM_OBJECT_FILES)
# After that, we'll copy linked binary to folder with GRUB config to properly build ISO image
	cp $(RELEASE_DIRECTORY)/$(TARGET_ARCH)/calypso-$(TARGET_ARCH).bin $(TARGET_DIRECTORY)/iso/calypso-$(TARGET_ARCH).bin
# And the last step before getting working ISO is to run this command to create ISO with GRUB installed
# This command installs GRUB config from iso/grub directory under TARGET_DIRECTORY
	grub-mkrescue /usr/lib/grub/i386-pc -o $(RELEASE_DIRECTORY)/$(TARGET_ARCH)/calypso-$(TARGET_ARCH).iso $(TARGET_DIRECTORY)/iso