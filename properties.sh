#!/bin/bash
#
# Generate list of missing properties files

gwt_dir=~/src/google-web-toolkit
dev_dir=${gwt_dir}/trunk/dev
core_dir=${dev_dir}/core

list=properties.txt

rm -f ${list}

for srcd in $(find src/com/google/gwt/dev -type d )
do
    tgtd=${core_dir}/${srcd}
    if [ -d ${tgtd} ]
    then
        if flist=$(2>/dev/null ls ${tgtd}/*.properties) && [ -n "${flist}" ]
        then
            for tgt in ${flist}
            do
                file=$(basename ${tgt} )

                src=${srcd}/${file}

                if [ ! -f ${src} ]
                then
                    echo ${src} | tee -a ${list}
                fi

            done
        fi
    else
        echo "Error, target not found '${tgtd}'"
        exit 1
    fi
done
exit 0
