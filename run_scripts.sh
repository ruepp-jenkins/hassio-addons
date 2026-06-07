#!/bin/sh

for script in $(find scripts -maxdepth 1 -name "*.sh" | sort); do
    echo "Running $script..."
    sh "$script"
done
