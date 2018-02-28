#!/bin/bash

export CLASSPATH=../rsl-terminal-0.1.1.jar:.
javac Order.java

if [ "$(uname)" == "Darwin" ]; then
    jlp=../z3mac
else
    jlp=../z3linux
fi
java -Djava.library.path=$jlp Order

