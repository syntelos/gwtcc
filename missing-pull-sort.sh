#!/bin/bash
#
# Sort - unique on {list}

list="missing-pull.txt"

touch ${list}

if egrep -v '^#' ${list}  | sort -u > /tmp/tmp
then
    if cp /tmp/tmp ${list}
    then
        wc -l ${list}
    else
        echo "Failure in 'cp /tmp/tmp ${list}'"
        exit 1
    fi
fi
exit 0
