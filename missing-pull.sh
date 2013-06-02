#!/bin/bash
#
# Pull missing class names from {list_in}
#     into 'src' tree file targets
#
# Copy written target file path names to {list_out}
#     (git adds)

gwt_dir=~/src/google-web-toolkit
dev_dir=${gwt_dir}/trunk

list_in="missing.txt"

list_out="missing-pull.txt"

for name in $(egrep -v '^#' ${list_in} )
do
    echo ${name}

    for src in $(find ${dev_dir} -type f -name "${name}.java")
    do

        tgt=$(echo $src | sed 's%.*/com/google/%src/com/google/%')
        if 2>/dev/null cp -p $src $tgt
        then
            if ! git add ${tgt}
            then
                echo "Warning, 'git add ${tgt}' failed"
            fi

            echo ${name} ${src}

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

                        echo ${name} ${src}

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
done
exit 0
