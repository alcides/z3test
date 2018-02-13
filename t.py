import os
import z3


print(z3.get_full_version())
print("OS: {} on {}".format(os.uname()[0], os.uname()[4]))


s = z3.Solver()
s.from_file("linux.txt")
print("Linux sexpr:" + str(s.check()))

s = z3.Solver()
s.from_file("macos.txt")
print("Macos sexpr:" + str(s.check()))