#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Assign argument to variable
directory=$1

# Check if the directory exists
if [ ! -d "$directory" ]; then
  echo "Error: Directory $directory does not exist."
  exit 1
fi

# Change to the specified directory
cd "$directory" || exit

# Get the timestamp of the first commit
first_commit=$(git log --reverse --format=%ct | head -n 1)

# Get the timestamp of the last commit
last_commit=$(git log --format=%ct | head -n 1)

# Convert timestamps to date format
first_commit_date=$(date -r "$first_commit" "+%Y%m%d%H%M.%S")
last_commit_date=$(date -r "$last_commit" "+%Y%m%d%H%M.%S")

# Change back to the parent directory
cd - > /dev/null

# Update the ctime and mtime of the directory
touch -t "$first_commit_date" "$directory"
touch -mt "$last_commit_date" "$directory"

echo "Updated $directory with ctime: $(date -r "$first_commit") and mtime: $(date -r "$last_commit")"
