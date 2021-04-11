#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "usage: ${0} <in_file> <out_file>"
    exit 1
fi

IN_FILE=$1
OUT_FILE=$2

>${OUT_FILE}

cat ${IN_FILE} | while read line
do
    first=$(echo $line | cut -d\; -f1)
    echo "${first};${line}" >>${OUT_FILE}
done
