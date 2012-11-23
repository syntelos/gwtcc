#!/bin/bash
#
# Pull missing properties files from {list_in}
#     into 'src' tree file targets
#
# Copy written target file path names to {list_out}
#     (git adds)

gwt_dir=~/src/google-web-toolkit
dev_dir=${gwt_dir}/trunk/dev
core_dir=${dev_dir}/core

list_in="properties.txt"

list_out="properties-pull.txt"

for tgt in $(egrep -v '^#' ${list_in} )
do
    echo ${tgt}

    src=${core_dir}/${tgt}

    if 2>/dev/null cp -p $src $tgt
    then
        if ! git add ${tgt}
        then
            echo "Warning, 'git add ${tgt}' failed"
        fi

        echo ${tgt} ${src}

        echo ${tgt} >> ${list_out}

    else
        tgtd=$(dirname ${tgt})
        if [ ! -d ${tgtd} ]
        then
            if mkdir -p ${tgtd}
            then
                if cp -p $src $tgt
                then
                    if ! git add ${tgt}
                    then
                        echo "Warning, 'git add ${tgt}' failed"
                    fi

                    echo ${tgt} ${src}

                    echo ${tgt} >> ${list_out}

                else
                    echo "Failure in 'cp $src $tgt'"
                    exit 1
                fi
            else
                echo "Failure in 'mkdir -p $tgtd'"
                exit 1
            fi
        else
            echo "Failure in 'cp $src $tgt'"
            exit 1
        fi
    fi

done
exit 0
