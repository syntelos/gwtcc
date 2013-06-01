#!/bin/bash

GWT=${GWT_TRUNK:-${HOME}/src/google-web-toolkit/trunk}

testlist="user dev/core dev/core/super"

if [ -n "${1}" ]&&[ -e "${1}" ]
then
    while [ -n "${1}" ]&&[ -e "${1}" ]
    do
        src="${1}"
        found=false
        for test in ${testlist}
        do
            tgt="${GWT}/${test}/${src}"
            if [ -e "${tgt}" ]
            then
                found=true
                echo "${tgt}"
                break
            elif [ -n "$(echo ${src} | egrep '^src/')" ]
            then
                retry=$(echo ${src} | sed 's%^src/%%')
                if [ "${retry}" != "${src}" ]
                then
                    tgt="${GWT}/${test}/${retry}"
                    if [ -e "${tgt}" ]
                    then
                        found=true
                        echo "${tgt}"
                        break
                    fi
                fi
            else
                retry="src/${src}"
                if [ "${retry}" != "${src}" ]
                then
                    tgt="${GWT}/${test}/${retry}"
                    if [ -e "${tgt}" ]
                    then
                        found=true
                        echo "${tgt}"
                        break
                    fi
                fi
            fi
        done
        if ! ${found}
        then
            1>&2 echo "Error, '${src}' not found"
            exit 1
        fi
        shift
    done
    exit 0
else
    cat<<EOF>&2
Usage
    $0 [src file|dir]* 
EOF
    exit 1
fi
