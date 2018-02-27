import os
import sys
import z3


if len(sys.argv) > 1:
    fname = sys.argv[1]
    z3.Z3_open_log(fname + "_python.log")
    s = z3.Solver()
    s.from_file(fname)
    print("python: " + str(s.check()))
    z3.Z3_close_log()
else:
    print(z3.get_full_version())

