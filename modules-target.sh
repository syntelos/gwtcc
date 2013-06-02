#!/bin/bash

for src in $(find  src/com/google/gwt/* -type d ) 
do
    if tgt=$(./target.sh $src)
    then
        for module in $(find ${tgt} -type f -name '*.gwt.xml')
        do
            echo $module
        done
    fi
done
