#!/usr/bin/env bash
set -euxo pipefail
PREFIX="$1"; SRC="$2"; OUT="$3"
export PATH="$PREFIX/bin:$PATH"
mkdir -p "$(dirname "$OUT")"
OBJ="${OUT%.xex}.o"
EXE="${OUT%.xex}.exe"
clang --target=powerpc-none-eabi -c "$SRC" -o "$OBJ" -O2 -ffreestanding -fno-builtin
# OpenXeChain's exact runtime/link recipe is intentionally validated here
# rather than silently fabricating one. If upstream tools require different
# flags, this step will fail with a preserved log for the next iteration.
lld-link /entry:main /subsystem:xbox /out:"$EXE" "$OBJ"
synthxex "$EXE" "$OUT"
