#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <git repo>"
  exit 1
fi

# Assign argument to variable
directory=$1

# Check if the directory exists
if [ ! -d "${directory}" ]; then
  echo "Error: Directory ${directory} does not exist."
  exit 1
fi

# Change to the specified directory
cd "${directory}" || exit

# Get the timestamp of the first commit
first_commit=$(git log --reverse --format=%ct | head -n 1)

# Get the timestamp of the last commit
last_commit=$(git log --format=%ct | head -n 1)

# Change back to the parent directory
> /dev/null cd -

# Update the ctime and mtime of the directory
touch -c -d "@$first_commit" "$directory"
touch -m -d "@$last_commit" "$directory"

echo "Updated $directory with ctime: $(date -d @$first_commit) and mtime: $(date -d @$last_commit)"
