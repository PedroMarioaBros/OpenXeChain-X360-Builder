#!/usr/bin/env python3
import pathlib,sys
p=pathlib.Path(sys.argv[1]); data=p.read_bytes()[:4]
print(p, "magic", data)
if data != b"XEX2":
    raise SystemExit("FAIL: output is not XEX2")
print("PASS: XEX2 header found")

# trigger-ci-official-buildscript
