#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    jlp=z3mac
else
    jlp=z3linux
fi


java -Djava.library.path=$jlp -jar rsl-terminal-0.1.1.jar Error.rspec


