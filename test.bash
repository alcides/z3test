#!/bin/bash

export CLASSPATH=rsl-terminal-0.1.1.jar:.
javac T.java

OS=`uname`
ARCH=`uname -m`
echo "OS: $OS $ARCH"

echo "--------- Java version --------- "
if [ "$(uname)" == "Darwin" ]; then
    jlp=z3mac
else
    export PYTHONPATH="z3linux/python/"
    PATH=./z3linux/:$PATH
    jlp=z3linux
fi
java -Djava.library.path=$jlp T


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


