#!/bin/bash

# Set the target directory for unzipping
TARGET_DIR="/opt/odoo/addons"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Loop through all .zip files in the current directory
for zipfile in ../Modules/misc/*.zip; do
    if [[ -f "$zipfile" ]]; then
        echo "Unzipping: $zipfile"
        unzip -o "$zipfile" -d "$TARGET_DIR"
    else
        echo "No zip files found in the current directory."
    fi
done