SHDC = $(shell which sokol-shdc)

FLAGS := --slang glsl430:metal_macos -f sokol_zig

GLSL := $(shell ls *.glsl)
GLSL_ZIG := ${GLSL:glsl=glsl.zig} 

.PHONY: all
all: ${GLSL_ZIG}

clean:
	rm -f ${GLSL_ZIG}

%.glsl.zig: %.glsl Makefile
	$(SHDC) ${FLAGS} --input $< --output $@