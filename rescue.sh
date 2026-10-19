#!/bin/bash

# ADB Rescue Tool - Extract data from failing Android storage
# Usage: ./rescue.sh <source_directory> <destination_directory>

SRC="$1"
DEST="$2"

if [ -z "$SRC" ] || [ -z "$DEST" ]; then
    echo "Usage: ./rescue.sh /storage/XXXX-XXXX ~/Backup"
    exit 1
fi

echo "🔍 Scanning $SRC..."
adb shell find "$SRC" -type f > /tmp/rescue_files.txt
TOTAL=$(wc -l < /tmp/rescue_files.txt)
echo "🚀 Found $TOTAL files. Starting rescue..."
COUNT=0

mkdir -p "$DEST"

while read -r f; do
    # Create the folder structure on the laptop
    d=$(dirname "$f")
    mkdir -p "$DEST$d"
    
    # Skip if file already exists and isn't 0 bytes
    if [ -s "$DEST$f" ]; then
        COUNT=$((COUNT+1))
        continue
    fi

    # Pull the file, ignore errors on corrupted files
    adb pull "$f" "$DEST$f" > /dev/null 2>&1
    
    # Pause to prevent CPU crashes on old laptops
    sleep 0.2
    
    COUNT=$((COUNT+1))
    if [ $((COUNT % 100)) -eq 0 ]; then
        echo "⏳ Progress: $COUNT / $TOTAL files..."
    fi
done < /tmp/rescue_files.txt

echo "✅ Rescue complete!"
