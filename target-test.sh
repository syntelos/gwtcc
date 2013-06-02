#!/bin/bash

successes=0
failures=0

for src in $(find  src/com/google/ -type d ) 
do
    if tgt=$(./target.sh $src)&& [ -d $tgt ]
    then
        echo ok $src
        successes=$(( ${successes} + 1 ))
    else
        echo ng $src
        failures=$(( ${failures} + 1 ))
    fi
done

if [ 0 -lt ${failures} ]
then
    1>&2 echo "NG, ${failures} test failures"
    exit 1
else
    1>&2 echo "OK, ${successes} test successes"
    exit 0
fi
