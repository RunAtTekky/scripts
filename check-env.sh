#!/bin/bash

CURR_DIR=$(pwd)

TARGET=".env"
PATTERN="os.environ"

ALL_FILES=$(find . -name '*.zip')

ZIP_CNT=$(find . -name '*.zip' | wc -l)
echo "Total zip files $ZIP_CNT"

UNZIP_LOCATION="/tmp/day-2/ml-unzipped"
mkdir -p "$UNZIP_LOCATION"

counter=0
while read file
do
    cd "$CURR_DIR"
    file_name=$(basename "$file" ".zip")
    DEST_FOLDER="$UNZIP_LOCATION/$file_name"
    if [[ ! -d "$DEST_FOLDER" ]]; then
        unzip "$file" -d "$DEST_FOLDER" &>/dev/null
    fi

    cnt=$(find "$DEST_FOLDER" -name "$TARGET" | wc -l)
    if [[ $cnt -ne 0 ]]; then
        echo "$file"
        find "$DEST_FOLDER" -name "$TARGET" | xargs -I _ cat _
        echo -e "\n---\n"
        ((counter++))
        # echo "$counter"
    fi

    cnt=$(grep -h -r --exclude-dir='*venv*' "$PATTERN" "$DEST_FOLDER" | grep -h -E "^.*=.*\'.{35}.*\'.*$" | wc -l)

    if [[ $cnt -ne 0 ]]; then
        echo "$file"
        grep -h -r --exclude-dir='*venv*' "$PATTERN" "$DEST_FOLDER" | grep -h -E "^.*=.*\'.{35}.*\'.*$"
        echo -e "\n---\n"
        ((counter++))
        # echo "$counter"
    fi
    # echo "---"
done <<< "$ALL_FILES"

echo "These many people exposed their API Keys: $counter"
