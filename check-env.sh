#!/bin/bash

CURR_DIR=$(pwd)

TARGET=".env"
DEST_FOLDER="res"

ALL_FILES=$(find . -name '*.zip')

ZIP_CNT=$(find . -name '*.zip' | wc -l)
echo "Total zip files $ZIP_CNT"


counter=0
while read line
do
    cd "$CURR_DIR"
    rm -rf "$DEST_FOLDER"
    unzip "$line" -d "$DEST_FOLDER" &>/dev/null

    cnt=$(find "$DEST_FOLDER" -name "$TARGET" | wc -l)
    if [[ $cnt -ne 0 ]]; then
        echo "$line"
        find "$DEST_FOLDER" -name "$TARGET" | xargs -I _ cat _
        echo -e "\n---\n"
        ((counter++))
        # echo "$counter"
    fi

    rm -rf "$DEST_FOLDER"
    # echo "---"
done <<< "$ALL_FILES"

echo "These many people exposed their API Keys: $counter"
