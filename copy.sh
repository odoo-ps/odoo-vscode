#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <destination_directory> <odoo_version> [workspace_name]"
    exit 1
fi

DEST_DIR=$1
ODOO_VERSION=$2
WORKSPACE_NAME=$3

VS_CODE_DIR="$DEST_DIR/.vscode"
mkdir -p "$VS_CODE_DIR"

SCRIPT_DIR="$(dirname "$0")"
SOURCE_FILE="$SCRIPT_DIR/odoo.code-workspace"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Source file $SOURCE_FILE does not exist."
    exit 1
fi

if [ -z "$WORKSPACE_NAME" ]; then
    EXISTING_WORKSPACE=$(find "$VS_CODE_DIR" -name '*.code-workspace' -print -quit)
    if [ -n "$EXISTING_WORKSPACE" ]; then
        WORKSPACE_NAME=$(basename "$EXISTING_WORKSPACE" .code-workspace)
    else
        WORKSPACE_NAME="$(basename $1)"
    fi
fi

DEST_FILE="$VS_CODE_DIR/$WORKSPACE_NAME.code-workspace"

cp -f "$SOURCE_FILE" "$DEST_FILE"

LIST_DIR=$(find "$1" -mindepth 1 -maxdepth 1 -type d ! -name '.*' -exec basename {} \; | tr '\n' ',' | sed 's/,$//')

sed -i "s/ODOO_VERSION/$ODOO_VERSION/g" "$DEST_FILE"
sed -i "s/TEMPLATE_MODULES/$LIST_DIR/g" "$DEST_FILE"

echo "Workspace file copied successfully."
