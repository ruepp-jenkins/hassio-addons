#!/bin/sh

find scripts -maxdepth 1 -name "*.sh" | sort | while IFS= read -r script; do
    echo "Running $script..."
    sh "$script"
done
