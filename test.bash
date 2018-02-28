#!/bin/bash

export CLASSPATH="z3mac/com.microsoft.z3.jar:."
javac T.java

OS=`uname`
ARCH=`uname -m`
echo "OS: $OS $ARCH"

echo "--------- Java version --------- "
if [ "$(uname)" == "Darwin" ]; then
    export jlp=/Users/alcides/Code/Research/z3test/z3mac/
    export LD_LIBRARY_PATH="$jlp":$LD_LIBRARY_PATH
    export PATH="z3mac":$PATH
    export PYTHONPATH="z3mac/python"
    export DYLD_LIBRARY_PATH="$jlp":DYLD_LIBRARY_PATH
else
    export PYTHONPATH="z3linux/python/"
    PATH=./z3linux/:$PATH
    jlp=/Users/alcides/Code/Research/z3test/z3linux
fi
java -Djava.library.path=/Users/alcides/Code/Research/z3test/z3mac/ T


echo "--------  Python version ------- "
python t.py


echo "-----  Command-line version ----- "
z3 --version

for m in *.smt2; do
  cp "$m" /tmp/model.smt2
  echo "(check-sat)" >> /tmp/model.smt2
  echo "--------------------------"
  echo "Model: $m"
  echo "cmline: $(z3 -smt2 /tmp/model.smt2) "
  python t.py "$m"
  java -Djava.library.path=$jlp T "$m"
  
  rm /tmp/model.smt2
done


