import os
import sys
import z3


if len(sys.argv) > 1:
    fname = sys.argv[1]
    z3.Z3_open_log(fname + "_java.log")
    s = z3.Solver()
    s.from_file(fname)
    print("python: " + str(s.check()))
else:
    print(z3.get_full_version())

