#!/bin/bash

# Array to store background process IDs
bg_pids=()

# Loop through each index for A and run in the background
for i in {1..10}; do
  ./arunner.sh $i &
  # Store the background process ID in the array
  bg_pids+=($!)
done

# Loop through each index for B and run in the background
for i in {1..10}; do
  ./brunner.sh $i &
  # Store the background process ID in the array
  bg_pids+=($!)
done

# Wait for all background processes to complete
for pid in "${bg_pids[@]}"; do
    wait "$pid"
done

# Execute the next step after all processes are done
cd ..
cd cleaner
bash results.sh
