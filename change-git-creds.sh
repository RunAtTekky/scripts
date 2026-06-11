#!/bin/bash

WORK_EMAIL_LINE="email = varunr@tekion.com"
WORK_NAME_LINE="name = Varun Rawat"

PERSONAL_EMAIL_LINE="email = varunrawat343@gmail.com"
PERSONAL_NAME_LINE="name = RunAtTekky"

file="$HOME/dotfiles/gitconfig/.gitconfig"

if [[ ! -f $file ]]; then
    echo "Could not find ~/.gitconfig"
    exit 1
fi

is_tekion_creds() {
    if grep "; $WORK_EMAIL_LINE" "$file" &> /dev/null; then
        return 1
    fi

    return 0
}

comment_line() {
    local line="$1"

    sed -i '' "s/$line/; $line/" "$file"
}

uncomment_line() {
    local line="$1"

    sed -i '' "s/; $line/$line/" "$file"
}

toggle_to_work() {
    local flag="$1"

    if [[ "$flag" == "true" ]]; then
        echo "Changing to work"
        comment_line "$PERSONAL_EMAIL_LINE"
        comment_line "$PERSONAL_NAME_LINE"

        uncomment_line "$WORK_EMAIL_LINE"
        uncomment_line "$WORK_NAME_LINE"
    else
        echo "Changing to personal"
        comment_line "$WORK_EMAIL_LINE"
        comment_line "$WORK_NAME_LINE"

        uncomment_line "$PERSONAL_EMAIL_LINE"
        uncomment_line "$PERSONAL_NAME_LINE"
    fi
}

if is_tekion_creds; then
    echo "Tekion creds"
    toggle_to_work false
else
    echo "Personal creds"
    toggle_to_work true
fi
