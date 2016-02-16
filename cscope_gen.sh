#!/usr/bin/env bash
dir=$2

echo "Locating files..."
find ${dir} -name '*.c' -o -name "*.h" -o -name "*.py" | xargs realpath > cscope.files

echo "Rebuilding cscope db..."
# -b: just build
# -q: create inverted index
cscope -b -q

echo "Rebuilding ctags db..."
# update ctags as well
ctags -L cscope.files
