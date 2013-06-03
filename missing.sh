#!/bin/bash
#
# Generate list of missing class names

list=missing.txt

rm -f ${list}

#
# output: class "SymbolName", one per line
#
function MissingSymbols {
    tmpf=/tmp/$(basename $0).$$

    2>&1 ant  | egrep '[A-Z][A-Za-z0-9_]+' > ${tmpf}

    egrep '^[Ss]ymbol' ${tmpf} | awk '{print $3 $4}' | sed 's/^class//; s/^variable//; s/^package//; s% %%g;' | egrep '^[A-Z]' 

    egrep 'package [A-Z][A-Za-z0-9_]* does not exist' ${tmpf} | sed 's/.* package //' | awk '{print $1}' | egrep '^[A-Z]' 

    rm -f ${tmpf}
}

#
#
#
for missing in $(MissingSymbols | sort -u) 
do
    echo ${missing} | tee -a ${list}
done

#
#
#
exit 0
