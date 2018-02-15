# Debugging process of z3 behaviour on RSL

rsl-terminal is a headrest specification validator. Headrest is a language used to specifify REST APIs. rsl-terminal
makes usage of z3 to validate subtyping, using the official Java bindings. rsl-terminal includes com.microsoft.z3 jar, but requires .so or .dylibs to be available in `java.library.path`.



## Problem 1

Running rsl-terminal (which has no OS-dependent code) using Error.rspec as input file, results in two different SMT models. These have been outputed using `solver.toString()`.

### How to replicate

`bash generate_test.bash` on MacOS or Native Linux

or

`docker run --interactive --tty --rm --volume "$PWD":/wd --workdir "/wd" --entrypoint "/wd/generate_test.bash" "confident/headrest"`


This will execute rsl-terminal with Error.rspec and output all the SMT2 models with the output (sat/unsat/unknown).

### Problem description

Running on macos generates a different SMT2 model than on Linux. Outputs for both linux and macos (z3 4.6.0) are in models_generated/{linux,macos}.txt. The same files suffixed with `_head.txt` represent the output using the master branch at commit `1323b8f63f21f40b7a264140ff84afa3dad989c8`.

These are different. Files {linux,macos}.txt at the root of this repo have just the smt2 models for the first sat-check that is generated in different ways according to the OS. The first lines were also manually reordered so they can be loaded by z3.


Different OSes should generate the same SMT2 model. This is not happening in these examples.


## Problem 1.2

The `Solver.toString()` method generates SMT2 code that is not loadable by either the command-line, python or java bindings. models_generated/linux.txt is one example of the invalid output (prefixed by `S:`).


## Problem 2

Executing the same SMT2 model gives "unknown" using the Java bindings, but outputs "unsat" if executed using either the Python bindings or the command line.

### How to replicate

`bash test.bash` on macos or native linux

or

```
docker run --interactive --tty --rm --volume "$PWD":/wd --workdir "/wd" --entrypoint "/wd/test.bash" "confident/headrest"
```


### Problem description

Regardless of one of the two examples used ({linux,macos}.txt models at the root dir), Java outputs unknown, while z3 and python z3 output "unsat". Bindings should not affect the behaviour. 

These results were all obtained using either z3 4.6 from the releases download page, or from z3 commit `1323b8f63f21f40b7a264140ff84afa3dad989c8`, compiled using gcc on docker linux, or clang on macos.

