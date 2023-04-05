#!/bin/bash

# This script replaces output symlinks generated by the amplicon pipeline for the actual files and directories they point to.

#Usage: ./symlinks_killer.sh path/to/Runs/target_directory

if [ $# -eq 0 ]; then
    echo "Please provide a directory as an argument."
    exit 1
fi

dir=$1

cd "$dir"

echo "STARTED PROCESSING SYMLINKS"

# replace symlinks of files with original files
find . -type l -exec sh -c 'rsync -r $(readlink -f {}) {}' \;

# replace symlinks of directories "Mapping" and "quality_report" with original directories
mkdir Mapping2 quality_report2

cp Mapping/* Mapping2/. 2>/dev/null
rm -r Mapping
mv Mapping2 Mapping 2>/dev/null

find Mapping/* -type l -exec sh -c 'rsync -r $(readlink -f {}) {}' \;

cp quality_report/* quality_report2/. 2>/dev/null
rm -r quality_report
mv quality_report2 quality_report 2>/dev/null

find quality_report/* -type l -exec sh -c 'rsync -r $(readlink -f {}) {}' \;

echo "DONE!"

