#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "usage: ${0} <in_file> <out_file>"
    exit 1
fi

IN_FILE=$1
OUT_FILE=$2

>new_vocab_audio.csv

cat ${IN_FILE} | while read line
do
    search_term=$(echo $line | cut -d\; -f1)
    rest=$(echo $line | cut -d\; -f2-)
    if [[ -f "files/${search_term}.mp3" ]]; then
        echo "already downloaded information for ${search_term}"
    else
        curl "https://apifree.forvo.com/key/$(cat api_key)/format/json/action/word-pronunciations/word/${search_term}/language/tr/order/rate-desc" -o "files/${search_term}.json" -s
        if [ $? -ne 0 ]; then
            echo "Failed to retrieve json for ${search_term}"
            continue
        fi
        audio_url=$(cat "files/${search_term}.json" | jq -j '.items[0].pathmp3')
        curl "${audio_url}" -o "files/${search_term}.mp3" -s
        if [ $? -ne 0 ]; then
            echo "Failed to retrieve audio for ${search_term}"
            continue
        fi
    fi
    echo "${rest}[sound:${search_term}.mp3]" >>${OUT_FILE}
    cp "files/${search_term}.mp3" ${ANKI_MEDIA}
done
