import os
import sys
import z3


if len(sys.argv) > 1:
    fname = sys.argv[1]
    s = z3.Solver()
    s.from_file(fname)
    print("python: " + str(s.check()))
else:
    print(z3.get_full_version())

