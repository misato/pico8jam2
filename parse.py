#!/usr/bin/env python

import sys
import os

if len(sys.argv) != 2:
    sys.exit("Usage: " + os.path.basename(sys.argv[0]) + " <sourcefile>")

sourceFile = file(sys.argv[1])
for line in sourceFile:
    lineStripped = line.strip()
    if not lineStripped.startswith("include"):
        print line,
    else:
        lineInclude = lineStripped.split()
        includeFile = file(lineInclude[1])
        for incLine in includeFile:
            print incLine,
        