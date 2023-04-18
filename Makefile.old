ifndef TARGET_ARCH
$(error "TARGET_ARCH is not available! You can pass it as environment variable by typing TARGET_ARCH=...")
endif

AS := nasm
AS_FLAGS := -f elf64

CC := $(TARGET_ARCH)-elf-gcc
CC_FLAGS := -c -ffreestanding

LD := $(TARGET_ARCH)-elf-ld
LD_FLAGS := -n

# Setting BASE directory, which contains this Makefile
BASE_DIRECTORY := $(PWD)

# After that we'll set path to SOURCES folder
SOURCES_DIRECTORY := $(BASE_DIRECTORY)/sources

# Setting BUILD_DIRECTORY, which contains compiled binary files
# Also setting RELEASE_DIRECTORY, where linked binaries will be stored
BUILD_DIRECTORY := $(BASE_DIRECTORY)/build
RELEASE_DIRECTORY := $(BASE_DIRECTORY)/release

TARGET_DIRECTORY := $(BASE_DIRECTORY)/targets/$(TARGET_ARCH)

TARGET_ASM_SOURCE_FILES := $(shell find $(SOURCES_DIRECTORY)/arch/$(TARGET_ARCH) -name *.asm)
TARGET_ASM_OBJECT_FILES := $(patsubst $(SOURCES_DIRECTORY)/arch/$(TARGET_ARCH)/%.asm, $(BUILD_DIRECTORY)/$(TARGET_ARCH)/%.o, $(TARGET_ASM_SOURCE_FILES))

UNIVERSAL_ASM_SOURCE_FILES := $(filter-out $(TARGET_ASM_SOURCE_FILES), $(shell find $(SOURCES_DIRECTORY) -name *.asm))
UNIVERSAL_ASM_OBJECT_FILES := $(patsubst $(SOURCES_DIRECTORY)/%.asm, $(BUILD_DIRECTORY)/%.o, $(UNIVERSAL_ASM_SOURCE_FILES))

debug:
	@echo $(UNIVERSAL_ASM_SOURCE_FILES)
	@echo $(UNIVERSAL_ASM_OBJECT_FILES)

$(TARGET_ASM_OBJECT_FILES): $(BUILD_DIRECTORY)/$(TARGET_ARCH)/%.o : $(SOURCES_DIRECTORY)/arch/$(TARGET_ARCH)/%.asm
	mkdir -p $(dir $@) && \
	$(AS) $(AS_FLAGS) $(patsubst $(BUILD_DIRECTORY)/$(TARGET_ARCH)/%.o, $(SOURCES_DIRECTORY)/arch/$(TARGET_ARCH)/%.asm, $@) -o $@

$(UNIVERSAL_ASM_OBJECT_FILES): $(BUILD_DIRECTORY)/%.o : $(SOURCES_DIRECTORY)/%.asm
	mkdir -p $(dir $@) && \
	$(AS) $(AS_FLAGS) $(patsubst $(BUILD_DIRECTORY)/%.o, $(SOURCES_DIRECTORY)/%.asm, $@) -o $@

ASM_OBJECT_FILES := $(TARGET_ASM_OBJECT_FILES) $(UNIVERSAL_ASM_OBJECT_FILES)

.PHONY: build-amd64
build-amd64: $(ASM_OBJECT_FILES)
	mkdir -p $(RELEASE_DIRECTORY)/$(TARGET_ARCH) && \
	$(LD) $(LD_FLAGS) -o $(RELEASE_DIRECTORY)/$(TARGET_ARCH)/calypso-$(TARGET_ARCH).bin -T $(TARGET_DIRECTORY)/linker.ld $(ASM_OBJECT_FILES) && \
	cp $(RELEASE_DIRECTORY)/$(TARGET_ARCH)/calypso-$(TARGET_ARCH).bin $(TARGET_DIRECTORY)/iso/boot/calypso-$(TARGET_ARCH).bin && \
	grub-mkrescue /usr/lib/grub/i386-pc -o $(RELEASE_DIRECTORY)/$(TARGET_ARCH)/calypso-$(TARGET_ARCH).iso $(TARGET_DIRECTORY)/iso