#!/bin/bash

function IsInnie {
    if [ -n "$(echo ${1} | egrep -e '\.[A-Z][^.]*\.[A-Z][^.]*')" ]
    then
        return 0
    else
        return 1
    fi
}
function ModuleFile {
    echo "src/$(echo ${1} | sed 's%\.%/%g; s%$%.gwt.xml%')"
}
function ClassFile {
    echo "src/$(echo ${1} | sed 's%\.%/%g; s%$%.java%')"
}

declare -A duplicate

for src in $(find src -type f -name '*.gwt.xml')
do
    for module_name in $(egrep '<inherits' "${src}" | sed 's%.*name="%%; s%".*%%')
    do
        mod_src=$(ModuleFile ${module_name})
        if [ -z "${duplicate[${mod_src}]}" ]
        then
            if [ ! -f "${mod_src}" ]
            then
                echo ${mod_src}
            fi
            duplicate[${mod_src}]=${mod_src}
        fi
    done
    for class in $(egrep 'class=' "${src}" | sed 's%.*class="%%; s%".*%%')
    do
        if IsInnie "${class}" 
        then
            class=$(echo $class | sed 's%\.[A-Za-z0-9_]*$%%')
        fi
        class_src=$(ClassFile ${class})
        if [ -z "${duplicate[${class_src}]}" ]
        then
            if [ ! -f "${class_src}" ]
            then
                echo ${class_src}
            fi
            duplicate[${class_src}]=${class_src}
        fi
    done
done
