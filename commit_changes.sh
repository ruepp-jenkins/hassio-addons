#!/bin/sh

if [ -n "$(git log @{u}..HEAD --oneline)" ]; then
    git push
    echo "Pushed pending commits"
else
    echo "No unpushed commits"
fi
