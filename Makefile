x86_64_asm_source_files := $(shell find sources/x86_64 -name *.asm)
x86_64_asm_object_files := $(patsubst sources/x86_64/%.asm, build/x86_64/%.o, $(x86_64_asm_source_files))

$(x86_64_asm_object_files): build/x86_64/%.o : sources/x86_64/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst build/x86_64/%.o, sources/x86_64/%.asm, $@) -o $@

.PHONY: build-x86_64
build-x86_64: $(x86_64_asm_object_files)
	mkdir -p release/x86_64 && \
	ld -m elf_x86_64 -o release/x86_64/kernel.bin -T targets/x86_64/linker.ld $(x86_64_asm_object_files) --oformat binary