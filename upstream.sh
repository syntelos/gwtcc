#!/bin/bash
#
# Dump svn info to {tgt}

gwt_dir=~/src/google-web-toolkit
trunk_dir=${gwt_dir}/trunk

tgt=upstream.txt

if [ -d ${trunk_dir} ]
then

    if svn info ${trunk_dir} | egrep -v '(^Path|UUID|Node|Schedule|Author|URL)' | egrep '[A-Z][a-z]*' > ${tgt}
    then
        cat -n ${tgt}
        wc -l ${tgt}
        exit 0
    else
        echo "Error in 'svn info' in '$(pwd)'"
        exit 1
    fi

else
    echo "Error, directory not found '${trunk_dir}'"
    exit 1
fi
