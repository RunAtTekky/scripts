#!/bin/bash

set -eou pipefail

# COLOUR CODES
RED=$'\e[31m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
RESET=$'\e[0m'

LOG_LEVEL="DEBUG"

# get_current_date_and_time() {
#   date
# }

log_info() {
  if [[ "$LOG_LEVEL" == "DEBUG" ]]; then
    echo -e "${GREEN}[INFO] - $1${RESET}"
  fi
}

log_info "Setting up our directory"

# # These are the files which I will be using
# BASE_DIR="/tmp/recommendation-test"

# VECTOR_DB_RESPONSE="$BASE_DIR/vector-db-response.json"
# IN_VECTOR_DB="$BASE_DIR/in-vector-db.json"

# VECTORID_TEMPLATENAME_IN_VECTOR_DB="$BASE_DIR/vectorId-templateName-in-vector-db.txt"
# IN_DB="$BASE_DIR/in-db.json"
# TEMPLATENAME_IN_DB="$BASE_DIR/templateName-in-db.txt"
# TEMPLATENAME_IN_VECTOR_DB="$BASE_DIR/templateName-in-vector-db.txt"

# COMMON_TEMPLATENAME="$BASE_DIR/result-common-templateName.json"
# ONLY_IN_VECTOR_DB_TEMPLATENAME="$BASE_DIR/result-only-in-vector-db-templateName.json"

# VECTOR_ID_OF_COMMON_TEMPLATE_NAME="$BASE_DIR/vector-id-of-common-template-name.json"
# VECTOR_ID_OF_UNIQUE_TEMPLATE_NAME="$BASE_DIR/vector-id-of-unique-template-name.json"
# COMMON_FILE="$BASE_DIR/common.json"
# UNIQUE_FILE="$BASE_DIR/unique.json"
# RESULT_COMMON="$BASE_DIR/res-common.json"
# RESULT_UNIQUE="$BASE_DIR/res-unique.json"

# mkdir -p "$BASE_DIR"

# # Get only the matches
# jq '.results[].matches' "$VECTOR_DB_RESPONSE" > "$IN_VECTOR_DB"

# # Get the vectorId and templateName
# jq -r '[
#     .[]
#     | {vectorId: .vectorId, templateName: .metadata.templateName}
# ]' "$IN_VECTOR_DB" > "$VECTORID_TEMPLATENAME_IN_VECTOR_DB"

# # Get the templateName present in vector DB
# jq -r '.[].templateName' "$VECTORID_TEMPLATENAME_IN_VECTOR_DB" > "$TEMPLATENAME_IN_VECTOR_DB"

# # Get the templateName present in TAO DB
# jq -r '.[].templateName' "$IN_DB" > "$TEMPLATENAME_IN_DB"

# # Find the missing templateName (only present in vector db)
# comm -13 "$TEMPLATENAME_IN_DB" "$TEMPLATENAME_IN_VECTOR_DB" > "$ONLY_IN_VECTOR_DB_TEMPLATENAME"

# # Find the common templateName
# comm -12 "$TEMPLATENAME_IN_DB" "$TEMPLATENAME_IN_VECTOR_DB" > "$COMMON_TEMPLATENAME"

# jq -R . "$COMMON_TEMPLATENAME" | jq -s . > "$COMMON_FILE"
# jq -R . "$ONLY_IN_VECTOR_DB_TEMPLATENAME" | jq -s . > "$UNIQUE_FILE"

# # Find the vectorId of common templateName
# jq --slurpfile ids "$COMMON_FILE" '[
#   .[]
#   | select(.metadata.templateName | IN($ids[][]))
#   | .vectorId
# ]' "$IN_VECTOR_DB" > "$RESULT_COMMON"

# # Find the vectorId of missing templateName
# jq --slurpfile ids "$UNIQUE_FILE" '[
#   .[]
#   | select(.metadata.templateName | IN($ids[][]))
#   | .vectorId
# ]' "$IN_VECTOR_DB" > "$RESULT_UNIQUE"
