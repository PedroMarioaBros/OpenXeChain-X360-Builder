#!/usr/bin/env python3
import pathlib, sys
p=pathlib.Path(sys.argv[1]); prefix=sys.argv[2]
s=p.read_text()
# Preserve upstream logic; only redirect the install prefix when the common
# /usr/local/xenon literal is present. Fail loudly if upstream changed.
candidates=["/usr/local/xenon","/usr/local/xenon/"]
hits=sum(s.count(x) for x in candidates)
if "/usr/local/xenon" not in s:
    raise SystemExit("Expected upstream prefix /usr/local/xenon not found; inspect upstream before changing CI")
s=s.replace("/usr/local/xenon", prefix.rstrip("/"))
p.write_text(s)
print("CI prefix patched:", prefix, "occurrences:", hits)
