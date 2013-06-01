#!/bin/bash


for src in $(find  src/com/google/ -type d ) 
do
 if tgt=$(./target.sh $src)&& [ -d $tgt ]
 then
     echo $tgt
 fi
done
exit 0
