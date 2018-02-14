#!/bin/bash

export CLASSPATH=rsl-terminal-0.1.1.jar:.
javac T.java

OS=`uname`
ARCH=`uname -m`
echo "OS: $OS $ARCH"

echo "--------- Java output --------- "
if [ "$(uname)" == "Darwin" ]; then
    java -Djava.library.path=z3mac T
else
    java -Djava.library.path=z3linux T
fi


if [ "$(uname)" != "Darwin" ]; then
    export PYTHONPATH="z3linux/python/"
fi

echo "--------  Python output ------- "
python t.py


echo "--------  Command output ------- "
z3 --version

for m in linux macos; do
  cp "$m.txt" t.model
  echo "(check-sat)" >> t.model
  echo "$m sexpr: $(z3 -smt2 t.model) "
  rm t.model
done


