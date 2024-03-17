#!/bin/bash
# This script will compress and move large files to the archive folder

# Variables
base="/run"
depth=1

# Check if directory exists
if [[ ! -d "$base" ]]; then
    echo "Directory does not exist: $base"
    exit 1
fi

# Create archive folder if it does not exist
archive_dir="$base/archive"
if [[ ! -d "$archive_dir" ]]; then
    mkdir "$archive_dir"
fi

# Find the list of larger files
for file in $(find "$base" -maxdepth "$depth" -type f -size +80M); do
    gzip "$file" || exit 1
    mv "$file.gz" "$archive_dir"
done
