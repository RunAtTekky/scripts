#!/bin/bash

CURR_DIR=$(pwd)

TARGET_FOLDER=".git"
DEST_FOLDER="res"

ALL_FILES=$(find . -name '*.zip')

CNT=$(find . -name '*.zip' | wc -l)
echo "Total zip files $CNT"

count_commits() {
    echo "Commit count:"
    cd "$DEST_FOLDER"

    git_folder=$(find . -name "$TARGET_FOLDER" -not -path '*__MACOS*')
    cd "$git_folder"

    cat logs/HEAD | wc -l

    cd "$CURR_DIR"
}

echo "$ALL_FILES" | while read line
do
    # echo "---"
    # echo "Reading: $line"
    cd "$CURR_DIR"
    rm -rf "$DEST_FOLDER"
    unzip "$line" -d "$DEST_FOLDER" &>/dev/null

    git_folders=$(find "$DEST_FOLDER" -name "$TARGET_FOLDER" | wc -l)
    if [[ $git_folders -ne 0 ]]; then
        echo "$line has git folder"
        count_commits
        echo "---"
    fi

    rm -rf "$DEST_FOLDER"
    # echo "---"
done

