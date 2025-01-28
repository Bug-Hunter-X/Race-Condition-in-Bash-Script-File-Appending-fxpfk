#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Function to append text to a file
append_to_file() {
  local file=$1
  local text=$2
  echo "$text" >> "$file"
}

# Function to read the content of a file
read_file() {
  local file=$1
  cat "$file"
}

# Start two processes concurrently
pid1=$(append_to_file file1.txt "Process 1 - Line 1" & echo $!) 
pid2=$(append_to_file file2.txt "Process 2 - Line 1" & echo $!) 

# Wait for the processes to complete
wait $pid1
wait $pid2

# Read the contents of both files
read_file file1.txt
read_file file2.txt
