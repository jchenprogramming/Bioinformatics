#!/bin/bash

# Loop through each index for A
for i in {1..10}; do
  ./arunner.sh $i
done

# Loop through each index for B
for i in {1..10}; do
  ./brunner.sh $i
done
