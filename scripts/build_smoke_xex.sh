#!/usr/bin/env bash
set -euxo pipefail
PREFIX="$1"
SRC="$2"
OUT="$3"
export PATH="$PREFIX/bin:$PATH"
mkdir -p "$(dirname "$OUT")"
OBJ="${OUT%.xex}.o"
EXE="${OUT%.xex}.exe"

# Compile as the Xbox 360 PowerPC target produced by OpenXeChain.
clang --target=ppc32-xbox360 -c "$SRC" -o "$OBJ" -O2 -ffreestanding -fno-builtin

# Mirror the current OpenXeChain CrossXbox360 linker recipe exactly.
lld-link \
  /SUBSYSTEM:xbox360 \
  /FIXED \
  /BASE:0x82000000 \
  /ALIGN:0x10000 \
  /ENTRY:_start \
  /OUT:"$EXE" \
  "$OBJ"

# SynthXEX's CLI requires explicit input/output options.
synthxex -i "$EXE" -o "$OUT"
