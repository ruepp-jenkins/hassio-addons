#!/bin/sh

UPSTREAM_VERSION=$(curl -sf "https://raw.githubusercontent.com/ruepp-jenkins/hassio-image-databasus/refs/heads/main/latest_version.txt" | tr -d '[:space:]')
if [ -z "$UPSTREAM_VERSION" ]; then
    echo "ERROR: Failed to fetch upstream version"
    exit 1
fi

LOCAL_VERSION=$(cat databasus/version.txt | tr -d '[:space:]')
if [ -z "$LOCAL_VERSION" ]; then
    echo "ERROR: Failed to read local version"
    exit 1
fi

COMBINED_VERSION="${UPSTREAM_VERSION}-${LOCAL_VERSION}"
echo "Setting databasus version to: ${COMBINED_VERSION}"

sed -i "s/^version: \".*\"/version: \"${COMBINED_VERSION}\"/" databasus/config.yaml
sed -i "s|^image: \"ruepp/hassio-image-databasus:.*\"|image: \"ruepp/hassio-image-databasus:${UPSTREAM_VERSION}\"|" databasus/config.yaml

if ! git diff --quiet databasus/config.yaml; then
    git add databasus/config.yaml
    git commit -m "ci: update databasus to ${UPSTREAM_VERSION} (${LOCAL_VERSION})"
    echo "Committed databasus update"
else
    echo "No changes detected for databasus"
fi
