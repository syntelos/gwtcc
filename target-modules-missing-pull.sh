#!/bin/bash

for tgt in $(./target.sh $(./modules-missing.sh ))
do
    src=$(echo $tgt | sed 's%.*/com/google/%src/com/google/%')
    srcd=$(dirname ${src} )
    if [ ! -d "${srcd}" ]
    then
        if ! mkdir -p ${srcd}
        then
            echo "Failed to create directory '${srcd}'"
            exit 1
        fi
    fi
    if ! cp ${tgt} ${src}
    then
        echo "Failed to copy onto '${src}'"
        exit 1
    fi
done
