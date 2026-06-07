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

# HA uses the `version` field as the Docker image tag, so it must equal the
# upstream tag exactly. The image field stays tagless (Supervisor appends the
# version as the tag). The wrapper version is tracked only in version.txt.
echo "Setting databasus version to: ${UPSTREAM_VERSION}"

sed -i "s/^version: \".*\"/version: \"${UPSTREAM_VERSION}\"/" databasus/config.yaml

if ! git diff --quiet databasus/config.yaml; then
    git add databasus/config.yaml
    git commit -m "ci: update databasus to ${UPSTREAM_VERSION} (${LOCAL_VERSION})"
    echo "Committed databasus update"
else
    echo "No changes detected for databasus"
fi
