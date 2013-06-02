#!/bin/bash
#
# Generate list of missing class names

list=missing.txt

rm -f ${list}

for missing in $(2>&1 ant | egrep 'symbol.*:.*(class|variable)' | awk '{print $3 $4}' | sed 's/class//; s/variable//;' | sort -u | egrep '^[A-Z][a-z]+')
do
    echo ${missing} | tee -a ${list}
done
exit 0
